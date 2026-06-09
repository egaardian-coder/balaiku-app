import 'package:flutter/material.dart';
import '../widgets/custom_appbar.dart';
import 'pasar_warga_screen.dart';
import 'layanan_screen.dart';
import 'daftar_warga_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10)]),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Warga Terdaftar', style: TextStyle(color: Colors.grey, fontSize: 12)),
                  SizedBox(height: 5),
                  Text('Darwin Nainggolan', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0D6EFD))),
                  Text('RT 01 RW 02', style: TextStyle(fontWeight: FontWeight.bold)),
                  Divider(height: 20),
                  Row(
                    children: [
                      Icon(Icons.campaign, color: Colors.orange),
                      SizedBox(width: 10),
                      Expanded(child: Text('Kerja Bakti hari Minggu jam 08:00 WIB', style: TextStyle(fontSize: 13))),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 25),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 4,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: [
                _buildMenu(context, 'Buat Surat', Icons.email, Colors.blue, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SuratScreen()))),
                _buildMenu(context, 'Form Laporan', Icons.description, Colors.blueAccent, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LaporanScreen()))),
                _buildMenu(context, 'Pasar Warga', Icons.storefront, Colors.orange, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PasarWargaScreen()))),
                _buildMenu(context, 'Daftar Warga', Icons.groups, Colors.green, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DaftarWargaScreen()))),
              ],
            ),
            const SizedBox(height: 25),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Aktivitas Terakhir', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text('Lihat Semua', style: TextStyle(color: Color(0xFF0D6EFD), fontSize: 12)),
              ],
            ),
            const SizedBox(height: 10),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10), side: BorderSide(color: Colors.grey.shade200)),
              child: ListTile(
                leading: const Icon(Icons.mark_email_read, color: Colors.green, size: 35),
                title: const Text('Surat Keterangan Pindah', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                subtitle: const Text('12 Mei 2026 | 14:30 WIB'),
                trailing: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(color: Colors.green.shade100, borderRadius: BorderRadius.circular(20)),
                  child: const Text('Selesai', style: TextStyle(color: Colors.green, fontSize: 12, fontWeight: FontWeight.bold)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMenu(BuildContext context, String title, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(15)),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 5),
          Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}