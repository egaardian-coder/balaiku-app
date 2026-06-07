import 'package:flutter/material.dart';

class PasarWargaScreen extends StatelessWidget {
  const PasarWargaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pasar Warga')),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          _buildItem(
            image: 'assets/images/kipas.jpg',
            title: 'Kipas Dinding Arashi',
            seller: 'Jaylani Umar',
            address: 'RT. 13 RW. 02\nJL. Rustam Tekno, Tanjung Senang',
            price: 'Rp. 120.000',
          ),
          const SizedBox(height: 15),
          _buildItem(
            image: 'assets/images/ps.jpg',
            title: 'Play Station 5',
            seller: 'Erik Rifanol',
            address: 'RT. 13 RW. 02\nJL. Raja Khodir, Tanjung Senang',
            price: 'Rp. 120.000',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF0D6EFD),
        onPressed: () {},
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildItem({required String image, required String title, required String seller, required String address, required String price}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.horizontal(left: Radius.circular(15)),
            child: Image.asset(image, width: 120, height: 130, fit: BoxFit.cover, errorBuilder: (c, e, s) => Container(width: 120, height: 130, color: Colors.grey[300], child: const Icon(Icons.image))),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 5),
                  Text(seller, style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.grey)),
                  Text(address, style: const TextStyle(fontSize: 11, color: Colors.grey)),
                  const SizedBox(height: 10),
                  Text(price, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0D6EFD), fontSize: 16)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}