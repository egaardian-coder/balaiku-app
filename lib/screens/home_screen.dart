import 'package:flutter/material.dart';
import 'pasar_warga_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/Balaiku.png', height: 40, errorBuilder: (c, e, s) => const Text('BalaiKu', style: TextStyle(fontWeight: FontWeight.bold))),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Kartu Warga Terdaftar
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10)]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Warga Terdaftar', style: TextStyle(color: Colors.grey, fontSize: 12)),
                  const SizedBox(height: 5),
                  const Text('Darwin Nainggolan', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0D6EFD))),
                  const Text('RT 01 RW 02', style: TextStyle(fontWeight: FontWeight.bold)),
                  const Divider(height: 20),
                  const Row(
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
            
            // Grid Menu Layanan
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 4,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: [
                _buildMenu(context, 'Buat Surat', Icons.email, Colors.blue, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SuratScreenDummy()))),
                _buildMenu(context, 'Form Laporan', Icons.description, Colors.blueAccent, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LaporanScreenDummy()))),
                _buildMenu(context, 'Pasar Warga', Icons.storefront, Colors.orange, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PasarWargaScreen()))),
                _buildMenu(context, 'Daftar Warga', Icons.groups, Colors.green, () {}),
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
            
            // List Aktivitas
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

class SuratScreenDummy extends StatelessWidget { const SuratScreenDummy({super.key}); @override Widget build(BuildContext context) { return Scaffold(appBar: AppBar(title: const Text('Pelayanan Surat')), body: const Center(child: Text('Halaman Buat Surat'))); } }
class LaporanScreenDummy extends StatelessWidget { const LaporanScreenDummy({super.key}); @override Widget build(BuildContext context) { return Scaffold(appBar: AppBar(title: const Text('Form Laporan')), body: const Center(child: Text('Halaman Laporan Warga'))); } }