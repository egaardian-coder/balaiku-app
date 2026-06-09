import 'package:flutter/material.dart';
import '../widgets/custom_appbar.dart';

class PasarWargaScreen extends StatefulWidget {
  const PasarWargaScreen({super.key});

  @override
  State<PasarWargaScreen> createState() => _PasarWargaScreenState();
}

class _PasarWargaScreenState extends State<PasarWargaScreen> {
  List<Map<String, String>> items = [
    {
      'image': 'assets/images/kipas.jpg',
      'title': 'Kipas Dinding Arashi',
      'seller': 'Jaylani Umar',
      'address': 'RT. 13 RW. 02\nJL. Rustam Tekno, Tanjung Senang',
      'price': 'Rp. 120.000',
    },
    {
      'image': 'assets/images/ps.jpg',
      'title': 'Play Station 5',
      'seller': 'Erik Rifanol',
      'address': 'RT. 13 RW. 02\nJL. Raja Khodir, Tanjung Senang',
      'price': 'Rp. 120.000',
    },
  ];

  void _addNewItem() {
    setState(() {
      items.add({
        'image': 'assets/images/Balaiku.png',
        'title': 'Produk Baru Warga',
        'seller': 'Warga Baru',
        'address': 'RT. 01 RW. 02\nJL. Pramuka, Bandar Lampung',
        'price': 'Rp. 50.000',
      });
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Barang berhasil ditambahkan!')));
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
            child: Text('Pasar Warga', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF0D6EFD))),
          ),
          Expanded(
            child: ListView.builder(
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
                        child: Image.asset(item['image']!, width: 120, height: 130, fit: BoxFit.cover, errorBuilder: (c, e, s) => Container(width: 120, height: 130, color: Colors.grey[200], child: const Icon(Icons.image))),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item['title']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              const SizedBox(height: 5),
                              Text(item['seller']!, style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.grey)),
                              Text(item['address']!, style: const TextStyle(fontSize: 11, color: Colors.grey)),
                              const SizedBox(height: 10),
                              Text(item['price']!, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0D6EFD), fontSize: 16)),
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
        backgroundColor: const Color(0xFF0D6EFD),
        onPressed: _addNewItem,
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }
}