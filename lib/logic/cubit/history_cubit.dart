import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';
import 'package:smart_parking_app1/data/models/parkir_log.dart';

class HistoryState {
  final List<ParkirLog> logs;
  HistoryState(this.logs);
}

class HistoryCubit extends Cubit<HistoryState> {
  final Isar isar;

  HistoryCubit({required this.isar}) : super(HistoryState([])) {
    loadLogs();
  }

  // Ambil semua riwayat dari database (diurutkan dari yang paling baru)
  Future<void> loadLogs() async {
    final allLogs = await isar.parkirLogs.where().sortByWaktuKejadianDesc().findAll();
    emit(HistoryState(allLogs));
  }

  // Tambah catatan baru otomatis saat ada aksi masuk / keluar
  Future<void> tambahLog(String jenisAksi, int sisaSlot) async {
    final logBaru = ParkirLog()
      ..jenisAksi = jenisAksi
      ..sisaSlotSaatItu = sisaSlot
      ..waktuKejadian = DateTime.now();

    await isar.writeTxn(() async {
      await isar.parkirLogs.put(logBaru);
    });

    loadLogs(); // Refresh daftar tampilan
  }
}