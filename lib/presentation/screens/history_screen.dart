import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_parking_app1/logic/cubit/history_cubit.dart';

class HistoryScreen extends StatelessWidget {
  // Menggunakan super parameter sesuai standar Dart modern
  const HistoryScreen({super.key});

  // Konstanta warna utama sesuai mockup riwayat
  static const Color primaryPink = Color(0xFFFF6595);

  // Fungsi pembantu konversi waktu lengkap (Hari, Tanggal, Bulan, Tahun, Jam)
  String _formatWaktuLengkap(DateTime dt) {
    const List<String> daftarHari = [
      'Senin',
      'Selasa',
      'Rabu',
      'Kamis',
      'Jumat',
      'Sabtu',
      'Minggu'
    ];

    const List<String> daftarBulan = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember'
    ];

    String namaHari = daftarHari[dt.weekday - 1];
    String namaBulan = daftarBulan[dt.month - 1];

    String jam = dt.hour.toString().padLeft(2, '0');
    String menit = dt.minute.toString().padLeft(2, '0');
    String detik = dt.second.toString().padLeft(2, '0');

    return "$namaHari, ${dt.day} $namaBulan ${dt.year} - $jam:$menit:$detik WIB";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
          0xFFF8F9FE), // Background canvas putih kebiruan sangat lembut
      appBar: AppBar(
        title: const Text(
          'Riwayat Parkir',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        backgroundColor: primaryPink,
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: BlocBuilder<HistoryCubit, HistoryState>(
        builder: (context, state) {
          if (state.logs.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.history_toggle_off_rounded,
                      size: 64, color: Colors.grey),
                  SizedBox(height: 12),
                  Text(
                    'Belum ada riwayat kendaraan melintas.',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(
                16), // Padding luar melonggarkan jarak card ke layar
            itemCount: state.logs.length,
            itemBuilder: (context, index) {
              final log = state.logs[index];

              // Sistem akan mengecek apakah teks di database diawali dengan kata "masuk"
              bool isMasuk =
                  log.jenisAksi.trim().toLowerCase().startsWith('masuk');

              // Menyesuaikan dengan mockup yang menggunakan warna pink transparan & ikon keluar/masuk
              Color warnaIkon = primaryPink;
              IconData ikonAksi =
                  isMasuk ? Icons.login_rounded : Icons.logout_rounded;

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.02),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 4.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 24,
                      backgroundColor: primaryPink.withValues(
                          alpha: 0.1), // Efek background pink transparan lembut
                      child: Icon(ikonAksi, color: warnaIkon, size: 22),
                    ),
                    title: Text(
                      isMasuk
                          ? 'Kendaraan Masuk Parkiran'
                          : 'Kendaraan Keluar Parkiran',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.black87,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 6.0),
                      child: Text(
                        _formatWaktuLengkap(log.waktuKejadian),
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(
                            0xFFF1F3F9), // Latar abu-abu cerah untuk badge slot
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Slot: ${log.sisaSlotSaatItu}',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[700],
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
