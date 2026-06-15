import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_parking_app1/logic/bloc/mqtt_bloc.dart';
import 'package:smart_parking_app1/logic/bloc/mqtt_state.dart';

class DashboardScreen extends StatelessWidget {
  // [FIXED]: Mengubah ke super parameter sesuai rekomendasi Flutter terbaru untuk menghilangkan warning
  const DashboardScreen({super.key});

  // Palet warna utama sesuai mockup (Maroon)
  static const Color primaryMaroon = Color(0xFFB32658);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCF9FA), // Latar belakang putih keabuan lembut
      appBar: AppBar(
        title: const Text(
          'Smart Parking Dashboard',
          style: TextStyle(
            fontWeight: FontWeight.bold, 
            color: primaryMaroon,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocBuilder<MqttBloc, MqttState>(
        builder: (context, state) {
          int sisaSlot = 10;
          String statusKoneksi = "Sistem Beroperasi Normal";
          Color warnaStatusBg = const Color(0xFFF9EAA4); // Kuning pastel dari gambar
          Color warnaStatusText = const Color(0xFF705E15);

          // Manajemen State untuk Status Alat
          if (state is MqttLoading) {
            statusKoneksi = "Menghubungkan Alat...";
            warnaStatusBg = Colors.orange[100]!;
            warnaStatusText = Colors.orange[800]!;
          } else if (state is MqttConnected) {
            sisaSlot = state.sisaSlot;
            statusKoneksi = "Sistem Beroperasi Normal";
            warnaStatusBg = const Color(0xFFF9EAA4);
            warnaStatusText = const Color(0xFF705E15);
          } else if (state is MqttDisconnected) {
            statusKoneksi = "Sistem Terputus";
            warnaStatusBg = Colors.red[100]!;
            warnaStatusText = Colors.red[800]!;
          }

          // Logika Warna Lingkaran & Pesan Berdasarkan Desain
          Color warnaLingkaran = primaryMaroon;
          String pesanKondisi = "Slot Tersedia";

          if (sisaSlot <= 0) {
            pesanKondisi = "PARKIRAN PENUH";
          } else if (sisaSlot <= 3) {
            pesanKondisi = "Slot Hampir Penuh";
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                // 1. Indikator Status Sistem di Bagian Atas
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: warnaStatusBg,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: warnaStatusText,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        statusKoneksi,
                        style: TextStyle(
                          color: warnaStatusText,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                
                // 2. Card Utama Dashboard
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.04),
                            blurRadius: 16,
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 16),
                          // Indikator Lingkaran Persentase/Slot
                          Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: warnaLingkaran, 
                                width: 14, 
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '$sisaSlot',
                                  style: TextStyle(
                                    fontSize: 54, 
                                    fontWeight: FontWeight.bold, 
                                    color: Colors.grey[800],
                                  ),
                                ),
                                Text(
                                  'SLOT',
                                  style: TextStyle(
                                    fontSize: 12, 
                                    fontWeight: FontWeight.w600, 
                                    color: Colors.grey[500],
                                    letterSpacing: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 32),
                          
                          // [FIXED]: Memperbaiki typo 'Colors.blackDE' menjadi 'Colors.black87' agar tidak error lagi
                          Text(
                            pesanKondisi,
                            style: const TextStyle(
                              fontSize: 24, 
                              fontWeight: FontWeight.bold, 
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Kapasitas Maksimal: 10 Kendaraan',
                            style: TextStyle(
                              color: Colors.grey[500], 
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 32),
                          
                          // Tombol Aksi "Parkir Sekarang"
                          SizedBox(
                            width: 200,
                            height: 48,
                            child: ElevatedButton(
                              onPressed: () {
                                // Aksi tombol parkir di sini
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryMaroon,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                elevation: 2,
                              ),
                              child: const Text(
                                'Parkir Sekarang',
                                style: TextStyle(
                                  fontSize: 15, 
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
    );
  }
}