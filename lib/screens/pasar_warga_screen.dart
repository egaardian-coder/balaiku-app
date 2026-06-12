import 'package:flutter/material.dart';
import '../widgets/custom_appbar.dart';
import '../helpers/database_helper.dart';

class PasarWargaScreen extends StatefulWidget {
  const PasarWargaScreen({super.key});

  @override
  State<PasarWargaScreen> createState() => _PasarWargaScreenState();
}

class _PasarWargaScreenState extends State<PasarWargaScreen> {
  List<Map<String, dynamic>> items = [];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    var data = await DatabaseHelper.instance.getAllUMKM();

    // DIPERBAIKI: Menambahkan 'no_telepon' pada data default agar tidak crash
    if (data.isEmpty) {
      await DatabaseHelper.instance.insertUMKM({
        'nama_usaha': 'Kipas Dinding Arashi',
        'penjual': 'Jaylani Umar',
        'alamat': 'RT. 13 RW. 02\nJL. Rustam Tekno, Tanjung Senang',
        'harga': 'Rp. 120.000',
        'gambar': 'assets/images/kipas.jpg',
        'no_telepon': '081234567890',
      });
      await DatabaseHelper.instance.insertUMKM({
        'nama_usaha': 'Play Station 5',
        'penjual': 'Erik Rifanol',
        'alamat': 'RT. 13 RW. 02\nJL. Raja Khodir, Tanjung Senang',
        'harga': 'Rp. 120.000',
        'gambar': 'assets/images/ps.jpg',
        'no_telepon': '085712345678',
      });
      data = await DatabaseHelper.instance.getAllUMKM();
    }

    setState(() {
      items = data;
    });
  }

  void _tambahBarangDialog() {
    final namaCtrl = TextEditingController();
    final penjualCtrl = TextEditingController();
    final alamatCtrl = TextEditingController();
    final hargaCtrl = TextEditingController();
    final noTelpCtrl =
        TextEditingController(); // Tambahan controller nomor telepon

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Text(
          'Tambah Dagangan',
          style: TextStyle(
            color: Color(0xFF185ABD),
            fontWeight: FontWeight.bold,
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: namaCtrl,
                decoration: const InputDecoration(labelText: 'Nama Produk'),
              ),
              TextField(
                controller: penjualCtrl,
                decoration: const InputDecoration(labelText: 'Nama Penjual'),
              ),
              TextField(
                controller: noTelpCtrl, // Form isian Nomor Telepon asli
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'No. Telepon / WA',
                ),
              ),
              TextField(
                controller: alamatCtrl,
                decoration: const InputDecoration(labelText: 'Alamat (RT/RW)'),
              ),
              TextField(
                controller: hargaCtrl,
                decoration: const InputDecoration(
                  labelText: 'Harga (Contoh: Rp 50.000)',
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF185ABD),
            ),
            onPressed: () async {
              if (namaCtrl.text.isEmpty || hargaCtrl.text.isEmpty) return;

              // DIPERBAIKI: Menyimpan data ketikan user beserta nomor teleponnya ke DB
              await DatabaseHelper.instance.insertUMKM({
                'nama_usaha': namaCtrl.text,
                'penjual': penjualCtrl.text,
                'alamat': alamatCtrl.text,
                'harga': hargaCtrl.text,
                'no_telepon': noTelpCtrl.text.isEmpty ? '-' : noTelpCtrl.text,
                'gambar': 'assets/images/Balaiku.png',
              });

              if (!context.mounted) return;
              Navigator.pop(context);
              _loadData();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Barang berhasil ditambahkan!')),
              );
            },
            child: const Text('Simpan', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // --- LOGIKA FILTER PENCARIAN ---
    final itemsDisaring = items.where((item) {
      final namaProduk = item['nama_usaha'].toString().toLowerCase();
      final namaPenjual = item['penjual'].toString().toLowerCase();
      final query = _searchQuery.toLowerCase();

      return namaProduk.contains(query) || namaPenjual.contains(query);
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(15, 15, 15, 5),
            child: Text(
              'Pasar Warga',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF185ABD),
              ),
            ),
          ),

          // --- FORM PENCARIAN ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Cari nama produk atau penjual...',
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
                  borderSide: const BorderSide(color: Color(0xFF185ABD)),
                ),
              ),
            ),
          ),

          Expanded(
            child: items.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : itemsDisaring.isEmpty
                ? Center(
                    child: Text(
                      'Data yang ditelusuri tidak ada.',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 15,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 5,
                    ),
                    itemCount: itemsDisaring.length,
                    itemBuilder: (context, index) {
                      final item = itemsDisaring[index];
                      return Card(
                        elevation: 2,
                        margin: const EdgeInsets.only(bottom: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.horizontal(
                                left: Radius.circular(15),
                              ),
                              child: Image.asset(
                                item['gambar'],
                                width: 120,
                                height: 140,
                                fit: BoxFit.cover,
                                errorBuilder: (c, e, s) => Container(
                                  width: 120,
                                  height: 140,
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Image.asset(
                                      'assets/images/Balaiku.png',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['nama_usaha'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      item['penjual'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(height: 4),

                                    // --- MENAMPILKAN NOMOR TELEPON ASLI DARI DATABASE ---
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.phone_android,
                                          size: 14,
                                          color: Colors.green,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          item['no_telepon'] ?? '-',
                                          style: const TextStyle(
                                            color: Colors.green,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      item['alamat'],
                                      style: const TextStyle(
                                        fontSize: 11,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      item['harga'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF185ABD),
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF185ABD),
        onPressed: _tambahBarangDialog,
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }
}
