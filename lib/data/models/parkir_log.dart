import 'package:isar/isar.dart';

part 'parkir_log.g.dart';

@collection
class ParkirLog {
  Id id = Isar.autoIncrement;

  late String jenisAksi; // "MASUK", "KELUAR", atau "DENIED"
  late int sisaSlotSaatItu;
  late DateTime waktuKejadian;
}