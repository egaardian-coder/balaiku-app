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

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    var data = await DatabaseHelper.instance.getAllUMKM();
    
    if (data.isEmpty) {
      await DatabaseHelper.instance.insertUMKM({
        'nama_usaha': 'Kipas Dinding Arashi',
        'penjual': 'Jaylani Umar',
        'alamat': 'RT. 13 RW. 02\nJL. Rustam Tekno, Tanjung Senang',
        'harga': 'Rp. 120.000',
        'gambar': 'assets/images/kipas.jpg'
      });
      await DatabaseHelper.instance.insertUMKM({
        'nama_usaha': 'Play Station 5',
        'penjual': 'Erik Rifanol',
        'alamat': 'RT. 13 RW. 02\nJL. Raja Khodir, Tanjung Senang',
        'harga': 'Rp. 120.000',
        'gambar': 'assets/images/ps.jpg'
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

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Text('Tambah Dagangan', style: TextStyle(color: Color(0xFF185ABD), fontWeight: FontWeight.bold)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: namaCtrl, decoration: const InputDecoration(labelText: 'Nama Produk')),
              TextField(controller: penjualCtrl, decoration: const InputDecoration(labelText: 'Nama Penjual')),
              TextField(controller: alamatCtrl, decoration: const InputDecoration(labelText: 'Alamat (RT/RW)')),
              TextField(controller: hargaCtrl, decoration: const InputDecoration(labelText: 'Harga (Contoh: Rp 50.000)')),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal', style: TextStyle(color: Colors.grey))),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF185ABD)),
            onPressed: () async {
              if (namaCtrl.text.isEmpty || hargaCtrl.text.isEmpty) return;
              
              await DatabaseHelper.instance.insertUMKM({
                'nama_usaha': namaCtrl.text,
                'penjual': penjualCtrl.text,
                'alamat': alamatCtrl.text,
                'harga': hargaCtrl.text,
                'gambar': 'assets/images/Balaiku.png', // Gambar default logo
              });
              
              if (!context.mounted) return;
              Navigator.pop(context);
              _loadData(); 
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Barang berhasil ditambahkan!')));
            },
            child: const Text('Simpan', style: TextStyle(color: Colors.white)),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(15.0),
            child: Text('Pasar Warga', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF185ABD))),
          ),
          Expanded(
            child: items.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.only(bottom: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.horizontal(left: Radius.circular(15)),
                        child: Image.asset(
                          item['gambar'], 
                          width: 120, height: 130, fit: BoxFit.cover, 
                          errorBuilder: (c, e, s) => Container(
                            width: 120, height: 130, color: Colors.white, 
                            child: Padding(padding: const EdgeInsets.all(10), child: Image.asset('assets/images/Balaiku.png'))
                          )
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item['nama_usaha'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              const SizedBox(height: 5),
                              Text(item['penjual'], style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.grey)),
                              Text(item['alamat'], style: const TextStyle(fontSize: 11, color: Colors.grey)),
                              const SizedBox(height: 10),
                              Text(item['harga'], style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF185ABD), fontSize: 16)),
                            ],
                          ),
                        ),
                      )
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