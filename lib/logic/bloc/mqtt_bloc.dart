import 'dart:async';
import 'dart:developer' as developer; 
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';

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

      _slotSubscription = mqttService.slotStream.listen((slot) {
        add(MqttSlotUpdated(slot)); 
      });

      _uidMasukSubscription = mqttService.uidMasukStream.listen((uid) {
        add(MqttUidScanned(uid)); 
      });

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
    // 3. HANDLER GERBANG MASUK (UNIT 1)
    // =========================================================================
    on<MqttUidScanned>((event, emit) async {
      _currentUid = event.uid; 

      final dataKtp = await isar.userKtps.filter().uidKartuEqualTo(event.uid).findFirst();

      // KONDISI A: KARTU INVALID / BELUM TERDAFTAR
      if (dataKtp == null || dataKtp.statusAktif != true) {
        mqttService.publishMessage('opik/parking/respon_masuk', 'ACC_REJECT'); 
        mqttService.publishMessage('opik/parking/masuk', 'REQ_REJECT');        
        
        developer.log("BLOC MASUK: Akses Ditolak! Kartu Tidak Valid (UID: ${event.uid})");
        emit(MqttConnected(sisaSlot: _currentSlot, scannetUid: _currentUid));
        return;
      }

      // [PERBAIKAN] KONDISI ANTI-PASSBACK MASUK: Mobil sudah di dalam tapi mau masuk lagi
      if (dataKtp.apakahDiDalam == true) {
        mqttService.publishMessage('opik/parking/respon_masuk', 'ACC_REJECT'); // Blokir Palang
        mqttService.publishMessage('opik/parking/masuk', 'REQ_ANTI_PASSBACK_MASUK'); // Kode baru untuk LCD ESP32 Masuk
        
        developer.log("BLOC MASUK: Anti-Passback Terdeteksi! ${dataKtp.namaPemilik} sudah di dalam.");
        
        // Catat ke log history sebagai percobaan masuk ilegal (diawali kata Keluar agar di UI terdeteksi gagal/merah/keluar)
        await historyCubit.tambahLog("Keluar - Gagal Masuk (Sudah Di Dalam) - ${dataKtp.namaPemilik}", _currentSlot);

        emit(MqttConnected(sisaSlot: _currentSlot, scannetUid: _currentUid));
        return; 
      }

      // KONDISI B: PARKIRAN FULL
      if (_currentSlot <= 0) {
        mqttService.publishMessage('opik/parking/respon_masuk', 'ACC_REJECT'); 
        mqttService.publishMessage('opik/parking/masuk', 'REQ_PENUH');         
        
        developer.log("BLOC MASUK: Akses Ditolak! Parkiran Penuh.");
        emit(MqttConnected(sisaSlot: _currentSlot, scannetUid: _currentUid));
        return;
      }

      // KONDISI C: AKSES MASUK BERHASIL
      mqttService.publishMessage('opik/parking/respon_masuk', 'ACC_BUKA');  
      mqttService.publishMessage('opik/parking/masuk', 'REQ_MASUK');        
      developer.log("BLOC MASUK: Akses Diterima untuk ${dataKtp.namaPemilik}");

      _currentSlot--;
      mqttService.publishMessage('opik/parking/status_slot', _currentSlot.toString());

      await isar.writeTxn(() async {
        dataKtp.apakahDiDalam = true; 
        await isar.userKtps.put(dataKtp);
      });

      await historyCubit.tambahLog("Masuk - ${dataKtp.namaPemilik}", _currentSlot);

      emit(MqttConnected(sisaSlot: _currentSlot, scannetUid: _currentUid));
    });

    // =========================================================================
    // 4. HANDLER GERBANG KELUAR (UNIT 2)
    // =========================================================================
    on<MqttUidKeluarScanned>((event, emit) async {
      _currentUid = event.uid;

      final dataKtp = await isar.userKtps.filter().uidKartuEqualTo(event.uid).findFirst();

      // KONDISI A: KARTU KELUAR INVALID
      if (dataKtp == null || dataKtp.statusAktif != true) {
        mqttService.publishMessage('opik/parking/respon_keluar', 'ACC_REJECT_KELUAR'); 
        mqttService.publishMessage('opik/parking/keluar', 'REQ_KELUAR_REJECT');         
        
        developer.log("BLOC KELUAR: Akses Ditolak! Kartu Tidak Valid (UID: ${event.uid})");
        emit(MqttConnected(sisaSlot: _currentSlot, scannetUid: _currentUid));
        return;
      }

      // [PERBAIKAN] KONDISI ANTI-PASSBACK KELUAR: Mobil di luar tapi mau scan keluar
      if (dataKtp.apakahDiDalam == false) {
        mqttService.publishMessage('opik/parking/respon_keluar', 'ACC_REJECT_KELUAR'); // Blokir Palang
        mqttService.publishMessage('opik/parking/keluar', 'REQ_ANTI_PASSBACK_KELUAR'); // Kode baru untuk LCD ESP32 Keluar
        
        developer.log("BLOC KELUAR: Status Ilegal! Kartu ${dataKtp.namaPemilik} tercatat belum masuk.");
        
        // Catat ke log history sebagai percobaan keluar ilegal (diawali kata Keluar agar di UI iconnya merah/keluar)
        await historyCubit.tambahLog("Keluar - Gagal Keluar (Belum Masuk) - ${dataKtp.namaPemilik}", _currentSlot);

        emit(MqttConnected(sisaSlot: _currentSlot, scannetUid: _currentUid));
        return; 
      }

      // KONDISI B: AKSES KELUAR BERHASIL
      mqttService.publishMessage('opik/parking/respon_keluar', 'ACC_BUKA_KELUAR'); 
      mqttService.publishMessage('opik/parking/keluar', 'REQ_KELUAR_ACC');         
      developer.log("BLOC KELUAR: Akses Keluar Diterima untuk ${dataKtp.namaPemilik}");

      if (_currentSlot < 10) {
        _currentSlot++;
        mqttService.publishMessage('opik/parking/status_slot', _currentSlot.toString());
      }

      await isar.writeTxn(() async {
        dataKtp.apakahDiDalam = false; 
        await isar.userKtps.put(dataKtp);
      });

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