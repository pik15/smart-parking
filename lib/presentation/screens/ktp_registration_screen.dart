import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';
import 'package:smart_parking_app1/data/models/user_ktp.dart';
import 'package:smart_parking_app1/logic/bloc/mqtt_bloc.dart';
import 'package:smart_parking_app1/logic/bloc/mqtt_state.dart';

class KtpRegistrationScreen extends StatefulWidget {
  const KtpRegistrationScreen({super.key});

  @override
  State<KtpRegistrationScreen> createState() => _KtpRegistrationScreenState();
}

class _KtpRegistrationScreenState extends State<KtpRegistrationScreen> {
  final _namaController = TextEditingController();
  final _uidController = TextEditingController();
  List<UserKtp> _registeredCards = [];
  late Isar _isar;

  // Warna utama berdasarkan mockup UI baru
  static const Color primaryPink = Color(0xFFFE6694);

  @override
  void initState() {
    super.initState();
    _isar = context.read<MqttBloc>().isar;
    _loadRegisteredCards();
  }

  Future<void> _loadRegisteredCards() async {
    final cards = await _isar.userKtps.where().findAll();
    setState(() {
      _registeredCards = cards;
    });
  }

  Future<void> _simpanKtp() async {
    if (_namaController.text.isEmpty || _uidController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nama dan UID tidak boleh kosong!')),
      );
      return;
    }

    final dataBaru = UserKtp()
      ..namaPemilik = _namaController.text
      ..uidKartu = _uidController.text
      ..tanggalDaftar = DateTime.now()
      ..statusAktif = true
      ..apakahDiDalam = false;

    await _isar.writeTxn(() async {
      await _isar.userKtps.put(dataBaru);
    });

    _namaController.clear();
    _uidController.clear();
    _loadRegisteredCards();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('E-KTP Berhasil Terdaftar!')),
      );
    }
  }

  Future<void> _hapusKtp(Id id) async {
    await _isar.writeTxn(() async {
      await _isar.userKtps.delete(id);
    });
    _loadRegisteredCards();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Kartu berhasil dihapus.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFF), // Warna dasar putih kebiruan bersih
      body: BlocListener<MqttBloc, MqttState>(
        listener: (context, state) async {
          if (state is MqttConnected && state.scannetUid.isNotEmpty) {
            final cekKartu = await _isar.userKtps.filter().uidKartuEqualTo(state.scannetUid).findFirst();
            if (cekKartu != null) return; 

            // [FIXED]: Memastikan widget masih mounted sebelum memanggil setState/context lintas async gap
            if (!mounted) return;

            setState(() {
              _uidController.text = state.scannetUid;
            });
            
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('UID Baru Terdeteksi: ${state.scannetUid}'), 
                backgroundColor: Colors.green
              ),
            );
          }
        },
        child: Column(
          children: [
            // 1. HEADER MELENGKUNG (Sesuai Gambar Mockup)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 60, bottom: 30, left: 24, right: 24),
              decoration: const BoxDecoration(
                color: primaryPink,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(36), // Efek lengkungan bawah oval
                ),
              ),
              child: const Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Spacer(),
                      Text(
                        'Smart Parking Dashboard',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      Spacer(),
                      Icon(Icons.notifications, color: Colors.white),
                    ],
                  ),
                  SizedBox(height: 8),
                  // [FIXED]: Mengganti 'Colors.whiteCC' typo menjadi white70 agar valid konstanta warnanya
                  Text(
                    'Registrasi Akses E-KTP',
                    style: TextStyle(fontSize: 15, color: Colors.white70, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),

            // BODY UTAMA DENGAN SCROLL
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20.0),
                children: [
                  // 2. CARD FORM PENDAFTARAN KARTU
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.03),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.badge_outlined, color: primaryPink),
                            SizedBox(width: 8),
                            Text(
                              'Daftarkan Kartu Baru',
                              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: primaryPink),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        
                        // Input Nama Pemilik
                        TextField(
                          controller: _namaController,
                          decoration: InputDecoration(
                            hintText: 'Nama Pemilik Kendaraan',
                            hintStyle: TextStyle(color: Colors.grey[400]),
                            prefixIcon: Icon(Icons.person, color: Colors.grey[400]),
                            filled: true,
                            fillColor: const Color(0xFFF8F9FD),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.grey[200]!, width: 1),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.grey[200]!, width: 1),
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        
                        // Input UID E-KTP
                        TextField(
                          controller: _uidController,
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: 'UID E-KTP (Tempelkan kartu...)',
                            hintStyle: TextStyle(color: Colors.grey[400]),
                            prefixIcon: Icon(Icons.developer_board_rounded, color: Colors.grey[400]),
                            filled: true,
                            fillColor: const Color(0xFFF8F9FD),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.grey[200]!, width: 1),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.grey[200]!, width: 1),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        
                        // Tombol Simpan Pengguna
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton.icon(
                            onPressed: _simpanKtp,
                            icon: const Icon(Icons.save_outlined, color: Colors.white, size: 20),
                            label: const Text(
                              'Simpan Pengguna',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryPink,
                              elevation: 0,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),
                  
                  // 3. SEKSI DAFTAR PENGGUNA TERDAFTAR (Header List)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'PENGGUNA E-KTP TERDAFTAR',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blueGrey[700], letterSpacing: 0.5),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFDF5D2), // Latar kuning pastel penanda jumlah
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '${_registeredCards.length} TOTAL',
                          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF6E5E1B)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  
                  // 4. LIST ITEM DENGAN BUILDER MANUAL DI LISTVIEW UTAMA
                  _registeredCards.isEmpty
                      ? const Padding(
                          padding: EdgeInsets.symmetric(vertical: 32.0),
                          child: Center(child: Text('Belum ada E-KTP yang terdaftar.', style: TextStyle(color: Colors.grey))),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _registeredCards.length,
                          itemBuilder: (context, index) {
                            final card = _registeredCards[index];
                            return Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: Colors.grey.withValues(alpha: 0.05)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.015),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                                leading: const CircleAvatar(
                                  radius: 22,
                                  backgroundColor: Color(0xFFE8F1FF), // Biru muda cerah untuk ikon KTP
                                  child: Icon(Icons.contact_mail_rounded, color: Color(0xFF3B82F6), size: 20),
                                ),
                                title: Text(
                                  card.namaPemilik,
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: Text(
                                    'UID: ${card.uidKartu}',
                                    style: TextStyle(color: Colors.grey[500], fontSize: 13, fontWeight: FontWeight.w500),
                                  ),
                                ),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete_outline_rounded, color: Color(0xFFEF4444), size: 24),
                                  onPressed: () => _hapusKtp(card.id),
                                ),
                              ),
                            );
                          },
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _namaController.dispose();
    _uidController.dispose();
    super.dispose();
  }
}