import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Wajib untuk baca memori
import '../helpers/database_helper.dart';

// Import halaman tujuan klik
import 'pasar_warga_screen.dart';
import 'daftar_warga_screen.dart';
import 'layanan_screen.dart';
import 'riwayat_screen.dart' hide SuratScreen, LaporanScreen;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Variabel penampung data dinamis
  String namaWarga = 'Memuat...';
  String alamatWarga = 'Memuat...';
  String inisial = '';

  @override
  void initState() {
    super.initState();
    _loadDataWarga();
  }

  // Fungsi untuk membaca memori HP hasil pendaftaran
  Future<void> _loadDataWarga() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      namaWarga = prefs.getString('nama_warga') ?? 'Warga Balaiku';
      alamatWarga = prefs.getString('alamat_warga') ?? 'Belum ada data';

      // Mengambil huruf pertama untuk avatar lingkaran
      if (namaWarga.isNotEmpty) {
        inisial = namaWarga.trim().substring(0, 1).toUpperCase();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F8FE),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            const SizedBox(height: 20),
            _buildMainMenu(),
            const SizedBox(height: 25),
            _buildRecentActivity(),
            const SizedBox(height: 40),
            _buildWatermark(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 25),
      decoration: const BoxDecoration(
        color: Color(0xFF0094FF),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: const Color(0xFF1976D2),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    // Lingkaran Foto Berubah Menjadi Inisial Nama (Bukan Ikon Orang Lagi)
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.white,
                      child: Text(
                        inisial,
                        style: const TextStyle(
                          color: Color(0xFF0094FF),
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Warga Terdaftar',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          // Nama yang ditarik otomatis dari memori
                          Text(
                            namaWarga,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        alamatWarga, // RT/RW yang ditarik otomatis dari memori
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.cleaning_services,
                        color: Colors.white,
                        size: 16,
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Kerja Bakti hari Minggu jam 08:00 WIB',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainMenu() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _menuItem(
            icon: Icons.mail_outline,
            title: 'Buat Surat',
            color: Colors.orange,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SuratScreen()),
              );
            },
          ),
          _menuItem(
            icon: Icons.assignment_outlined,
            title: 'Form Laporan',
            color: Colors.orangeAccent,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LaporanScreen()),
              );
            },
          ),
          _menuItem(
            icon: Icons.storefront,
            title: 'Pasar Warga',
            color: Colors.black87,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PasarWargaScreen(),
                ),
              );
            },
          ),
          _menuItem(
            icon: Icons.list_alt,
            title: 'Daftar Warga',
            color: Colors.teal,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DaftarWargaScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _menuItem({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.15),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Icon(icon, color: color, size: 30),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }

  // --- WIDGET AKTIVITAS TERAKHIR ---
  Widget _buildRecentActivity() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Aktivitas Terakhir',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RiwayatScreen(),
                    ),
                  );
                },
                child: const Text(
                  'Lihat Semua',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),

          FutureBuilder<List<List<Map<String, dynamic>>>>(
            future: Future.wait([
              DatabaseHelper.instance.getAllSurat(),
              DatabaseHelper.instance.getAllLaporan(),
            ]),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              final listSurat = snapshot.data?[0] ?? [];
              final listLaporan = snapshot.data?[1] ?? [];

              if (listSurat.isEmpty && listLaporan.isEmpty) {
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Center(
                    child: Text(
                      'Belum ada aktivitas pengajuan.',
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  ),
                );
              }

              List<Map<String, dynamic>> combinedList = [];
              if (listSurat.isNotEmpty) combinedList.add(listSurat.first);
              if (listLaporan.isNotEmpty) combinedList.add(listLaporan.first);

              return Column(
                children: combinedList.map((item) {
                  bool isSurat = item.containsKey('jenis_surat');
                  String judul = isSurat
                      ? item['jenis_surat']
                      : item['jenis_laporan'];
                  IconData iconData = isSurat ? Icons.mail : Icons.assignment;
                  Color iconBgColor = isSurat
                      ? const Color(0xFF0094FF)
                      : Colors.orange;

                  String tanggalRaw = item['tanggal'] ?? '';
                  String status = item['status'] ?? 'Proses';
                  String tanggalTampil = tanggalRaw.length > 16
                      ? tanggalRaw.substring(0, 16)
                      : tanggalRaw;

                  Color statusColor = Colors.orange;
                  if (status == 'Selesai') {
                    statusColor = const Color(0xFF00E676);
                  }
                  if (status == 'Ditolak') statusColor = Colors.red;

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RiwayatScreen(),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: iconBgColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(iconData, color: Colors.white),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  judul,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  tanggalTampil,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: statusColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              status,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildWatermark() {
    return Opacity(
      opacity: 0.15,
      child: Image.asset(
        'assets/images/balaikubg.png',
        height: 150,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.broken_image, size: 100, color: Colors.grey);
        },
      ),
    );
  }
}
