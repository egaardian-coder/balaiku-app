import 'package:flutter/material.dart';
import '../widgets/custom_appbar.dart';

class DaftarWargaScreen extends StatefulWidget {
  const DaftarWargaScreen({super.key});

  @override
  State<DaftarWargaScreen> createState() => _DaftarWargaScreenState();
}

class _DaftarWargaScreenState extends State<DaftarWargaScreen> {
  // Variabel untuk menyimpan teks yang diketik di pencarian
  String _searchQuery = '';

  // Data tiruan yang bervariasi agar fitur pencarian bisa dicoba
  final List<Map<String, dynamic>> _semuaWarga = [
    {
      'keluarga': 'Keluarga Jaylani',
      'kepala': 'Jaylani Umar',
      'anggota': 4,
      'alamat': 'Jalan Imam Bonjol No. 12, Banjar Agung',
      'rt': 'RT 01 RW 02',
    },
    {
      'keluarga': 'Keluarga Budi Santoso',
      'kepala': 'Budi Santoso',
      'anggota': 3,
      'alamat': 'Jalan Melati No. 5, Banjar Agung',
      'rt': 'RT 01 RW 02',
    },
    {
      'keluarga': 'Keluarga Ahmad Dahlan',
      'kepala': 'Ahmad Dahlan',
      'anggota': 5,
      'alamat': 'Jalan Merdeka No. 8, Banjar Agung',
      'rt': 'RT 03 RW 02',
    },
    {
      'keluarga': 'Keluarga Siti Aminah',
      'kepala': 'Siti Aminah',
      'anggota': 2,
      'alamat': 'Jalan Sudirman No. 10, Banjar Agung',
      'rt': 'RT 03 RW 02',
    },
    {
      'keluarga': 'Keluarga Rina Melati',
      'kepala': 'Rina Melati',
      'anggota': 4,
      'alamat': 'Jalan Mawar No. 3, Banjar Agung',
      'rt': 'RT 03 RW 02',
    },
  ];

  @override
  Widget build(BuildContext context) {
    // --- LOGIKA PENYARINGAN PENCARIAN ---
    final wargaDisaring = _semuaWarga.where((warga) {
      final namaKeluarga = warga['keluarga'].toString().toLowerCase();
      final namaKepala = warga['kepala'].toString().toLowerCase();
      final query = _searchQuery.toLowerCase();

      // Mencari berdasarkan nama keluarga atau nama kepala keluarga
      return namaKeluarga.contains(query) || namaKepala.contains(query);
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- JUDUL HALAMAN ---
          const Padding(
            padding: EdgeInsets.fromLTRB(15, 15, 15, 5),
            child: Text(
              'Daftar Warga',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0D6EFD),
              ),
            ),
          ),

          // --- FORM PENCARIAN (SEARCH BAR) ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery =
                      value; // Memperbarui layar setiap ada huruf diketik
                });
              },
              decoration: InputDecoration(
                hintText: 'Cari nama keluarga...',
                hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 20,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Color(0xFF0D6EFD)),
                ),
              ),
            ),
          ),

          // --- HASIL PENCARIAN / DAFTAR WARGA ---
          Expanded(
            child: wargaDisaring.isEmpty
                // Jika data yang diketik tidak ditemukan
                ? Center(
                    child: Text(
                      'Data warga yang ditelusuri tidak ada.',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 15,
                      ),
                    ),
                  )
                // Jika data ditemukan, tampilkan daftar
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 5,
                    ),
                    itemCount: wargaDisaring.length,
                    itemBuilder: (context, index) {
                      final data = wargaDisaring[index];
                      return Column(
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              data['keluarga'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 2),
                                Text(
                                  data['alamat'],
                                  style: const TextStyle(fontSize: 12),
                                ),
                                const SizedBox(height: 4),
                                // Menampilkan Badge RT/RW kecil
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    data['rt'],
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: Colors.grey,
                            ),
                            onTap: () {
                              _tampilkanDetail(context, data);
                            },
                          ),
                          const Divider(height: 1),
                        ],
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  // --- WIDGET POP-UP BOTTOM SHEET (DETAIL WARGA) ---
  void _tampilkanDetail(BuildContext context, Map<String, dynamic> data) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Detail ${data['keluarga']}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0D6EFD),
              ),
            ),
            const Divider(),
            Text(
              'Kepala Keluarga: ${data['kepala']}',
              style: const TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 5),
            Text(
              'Jumlah Anggota: ${data['anggota']} Orang',
              style: const TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 5),
            Text(
              'Alamat: ${data['rt']}, ${data['alamat']}',
              style: const TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0D6EFD),
                minimumSize: const Size(double.infinity, 45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Tutup',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
