import 'package:isar/isar.dart';

part 'user_ktp.g.dart';

@collection
class UserKtp {
  Id id = Isar.autoIncrement;

  late String namaPemilik;
  late String uidKartu; // Menyimpan ID Unik kartu hasil scan RFID ESP 1
  late DateTime tanggalDaftar;
  late bool statusAktif; // true jika diizinkan masuk, false jika diblokir
  
  // 🔴 TAMBAHKAN BARIS INI (Gunakan bool? agar data lama yang null tidak bikin error)
  bool? apakahDiDalam; 
}