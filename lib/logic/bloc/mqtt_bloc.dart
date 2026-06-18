import 'dart:async';
import 'dart:developer' as developer; 
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';

// MENGGUNAKAN JALUR RELATIF AGAR AMAN DARI ERROR PUBSPEC.YAML
import '../../data/models/user_ktp.dart'; 
import '../../data/services/mqtt_service.dart'; 
import '../cubit/history_cubit.dart'; 

import 'mqtt_event.dart';
import 'mqtt_state.dart';

class MqttBloc extends Bloc<MqttEvent, MqttState> {
  final MqttService mqttService;
  final Isar isar;
  final HistoryCubit historyCubit; 

  StreamSubscription<int>? _slotSubscription;
  StreamSubscription<String>? _uidMasukSubscription;   
  StreamSubscription<String>? _uidKeluarSubscription; 

  int _currentSlot = 10;
  String _currentUid = '';

  MqttBloc({
    required this.mqttService, 
    required this.isar,
    required this.historyCubit, 
  }) : super(MqttInitial()) {
    
    // =========================================================================
    // 1. HANDLER KONEKSI MQTT (MULTI-GATE KONEKSI)
    // =========================================================================
    on<MqttConnectRequested>((event, emit) async {
      emit(MqttLoading());
      
      await _slotSubscription?.cancel();
      await _uidMasukSubscription?.cancel();
      await _uidKeluarSubscription?.cancel();

      await mqttService.setupMqtt(); 

      // Mendengarkan perubahan slot dari broker
      _slotSubscription = mqttService.slotStream.listen((slot) {
        add(MqttSlotUpdated(slot)); 
      });

      // Mendengarkan scan kartu dari Gerbang Masuk (ESP 1)
      _uidMasukSubscription = mqttService.uidMasukStream.listen((uid) {
        add(MqttUidScanned(uid)); 
      });

      // Mendengarkan scan kartu dari Gerbang Keluar (ESP 2)
      _uidKeluarSubscription = mqttService.uidKeluarStream.listen((uid) {
        add(MqttUidKeluarScanned(uid)); 
      });
      
      emit(MqttConnected(sisaSlot: _currentSlot, scannetUid: _currentUid));
    });

    // =========================================================================
    // 2. HANDLER UPDATE SLOT VIA STREAM INTERNET
    // =========================================================================
    on<MqttSlotUpdated>((event, emit) {
      _currentSlot = event.newSlot; 
      emit(MqttConnected(sisaSlot: _currentSlot, scannetUid: _currentUid));
    });

    // =========================================================================
    // 3. HANDLER GERBANG MASUK (UNIT 1) - TERINTEGRASI LCD MONITOR & LED
    // =========================================================================
    on<MqttUidScanned>((event, emit) async {
      _currentUid = event.uid; 

      // Ambil data KTP dari local database Isar berdasarkan UID Kartu
      final dataKtp = await isar.userKtps.filter().uidKartuEqualTo(event.uid).findFirst();

      // KONDISI A: KARTU INVALID / BELUM TERDAFTAR DI DATABASE ISAR
      if (dataKtp == null || dataKtp.statusAktif != true) {
        mqttService.publishMessage('opik/parking/respon_masuk', 'ACC_REJECT'); // Perintah Blokir Palang Servo ESP 1
        mqttService.publishMessage('opik/parking/masuk', 'REQ_REJECT');        // Perintah Cetak Eror di LCD & Nyalakan LED Monitor
        
        developer.log("BLOC MASUK: Akses Ditolak! Kartu Tidak Valid (UID: ${event.uid})");
        emit(MqttConnected(sisaSlot: _currentSlot, scannetUid: _currentUid));
        return;
      }

      // [BARU] KONDISI ANTI-PASSBACK MASUK: Jika kartu terdeteksi sudah ada di dalam
      if (dataKtp.apakahDiDalam == true) {
        mqttService.publishMessage('opik/parking/respon_masuk', 'ACC_REJECT'); // Blokir Palang Servo ESP 1
        mqttService.publishMessage('opik/parking/masuk', 'REQ_REJECT');        // Nyalakan tanda error di LCD/LED
        
        developer.log("BLOC MASUK: Anti-Passback Terdeteksi! Kartu ${dataKtp.namaPemilik} sudah berada di dalam.");
        emit(MqttConnected(sisaSlot: _currentSlot, scannetUid: _currentUid));
        return; // Hentikan alur, palang tidak akan terbuka
      }

      // KONDISI B: PARKIRAN FULL / SISA SLOT SUDAH HABIS (<= 0)
      if (_currentSlot <= 0) {
        mqttService.publishMessage('opik/parking/respon_masuk', 'ACC_REJECT'); 
        mqttService.publishMessage('opik/parking/masuk', 'REQ_PENUH');         
        
        developer.log("BLOC MASUK: Akses Ditolak! Parkiran Penuh.");
        emit(MqttConnected(sisaSlot: _currentSlot, scannetUid: _currentUid));
        return;
      }

      // KONDISI C: AKSES MASUK BERHASIL VALID DAN AMAN
      mqttService.publishMessage('opik/parking/respon_masuk', 'ACC_BUKA');  // Perintah Buka Palang Servo ESP 1
      mqttService.publishMessage('opik/parking/masuk', 'REQ_MASUK');        // Perintah LCD Berhasil & LED Kedip Cepat 2x
      developer.log("BLOC MASUK: Akses Diterima untuk ${dataKtp.namaPemilik}");

      // Kurangi sisa slot di aplikasi dan sinkronkan ke server pusat MQTT
      _currentSlot--;
      mqttService.publishMessage('opik/parking/status_slot', _currentSlot.toString());

      // Update data transaksi kartu ke Isar Database & kunci status ke dalam (true)
      await isar.writeTxn(() async {
        dataKtp.apakahDiDalam = true; // <--- Mengubah status kartu menjadi di dalam parkiran
        await isar.userKtps.put(dataKtp);
      });

      // Tambahkan data ke Log Riwayat Aktivitas (HistoryCubit)
      await historyCubit.tambahLog("Masuk - ${dataKtp.namaPemilik}", _currentSlot);

      emit(MqttConnected(sisaSlot: _currentSlot, scannetUid: _currentUid));
    });

    // =========================================================================
    // 4. HANDLER GERBANG KELUAR (UNIT 2) - TERINTEGRASI LCD MONITOR & LED
    // =========================================================================
    on<MqttUidKeluarScanned>((event, emit) async {
      _currentUid = event.uid;

      // Ambil data KTP dari database Isar untuk pengecekan validitas keluar
      final dataKtp = await isar.userKtps.filter().uidKartuEqualTo(event.uid).findFirst();

      // KONDISI A: KARTU KELUAR INVALID / BELUM SCAN MASUK SEBELUMNYA
      if (dataKtp == null || dataKtp.statusAktif != true) {
        mqttService.publishMessage('opik/parking/respon_keluar', 'ACC_REJECT_KELUAR'); // Perintah Blokir Palang Servo ESP 2
        mqttService.publishMessage('opik/parking/keluar', 'REQ_KELUAR_REJECT');         // Perintah LCD Keluar Gagal & LED Menyala Diam
        
        developer.log("BLOC KELUAR: Akses Ditolak! Kartu Tidak Valid (UID: ${event.uid})");
        emit(MqttConnected(sisaSlot: _currentSlot, scannetUid: _currentUid));
        return;
      }

      // [BARU] KONDISI ANTI-PASSBACK KELUAR: Jika kartu terdeteksi masih di luar (belum masuk tapi mau keluar)
      if (dataKtp.apakahDiDalam == false) {
        mqttService.publishMessage('opik/parking/respon_keluar', 'ACC_REJECT_KELUAR'); // Blokir Palang Servo ESP 2
        mqttService.publishMessage('opik/parking/keluar', 'REQ_KELUAR_REJECT');
        
        developer.log("BLOC KELUAR: Status Ilegal! Kartu ${dataKtp.namaPemilik} tercatat belum masuk.");
        emit(MqttConnected(sisaSlot: _currentSlot, scannetUid: _currentUid));
        return; // Hentikan alur
      }

      // KONDISI B: AKSES KELUAR BERHASIL DAN VALID
      mqttService.publishMessage('opik/parking/respon_keluar', 'ACC_BUKA_KELUAR'); // Perintah Buka Palang Servo ESP 2
      mqttService.publishMessage('opik/parking/keluar', 'REQ_KELUAR_ACC');         // Perintah LCD Keluar Berhasil & LED Kedip Cepat 2x
      developer.log("BLOC KELUAR: Akses Keluar Diterima untuk ${dataKtp.namaPemilik}");

      // Tambah kembali jumlah sisa slot jika slot belum maksimal (10)
      if (_currentSlot < 10) {
        _currentSlot++;
        mqttService.publishMessage('opik/parking/status_slot', _currentSlot.toString());
      }

      // Update data status ke Isar Database & reset status kembali ke luar (false)
      await isar.writeTxn(() async {
        dataKtp.apakahDiDalam = false; // <--- Mengembalikan status kartu menjadi di luar parkiran
        await isar.userKtps.put(dataKtp);
      });

      // Tambahkan log keluar ke riwayat tabel history
      await historyCubit.tambahLog("Keluar - ${dataKtp.namaPemilik}", _currentSlot);

      emit(MqttConnected(sisaSlot: _currentSlot, scannetUid: _currentUid));
    });
  }

  @override
  Future<void> close() {
    _slotSubscription?.cancel();
    _uidMasukSubscription?.cancel();
    _uidKeluarSubscription?.cancel();
    return super.close();
  }
}