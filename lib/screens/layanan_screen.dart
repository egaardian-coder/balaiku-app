import 'package:flutter/material.dart';
import '../widgets/custom_appbar.dart';

class SuratScreen extends StatelessWidget {
  const SuratScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Pelayanan Surat', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF0D6EFD))),
            const SizedBox(height: 20),
            const Text('Pilih Jenis Surat', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
              value: 'Surat Pengantar RT/RW',
              items: ['Surat Pengantar RT/RW', 'Surat Keterangan Usaha', 'Surat Keterangan Pindah'].map((String value) {
                return DropdownMenuItem<String>(value: value, child: Text(value));
              }).toList(),
              onChanged: (_) {},
            ),
            const SizedBox(height: 20),
            const Text('Tujuan / Keperluan', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            TextField(
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Contoh: Mengurus Pendaftaran\nSekolah',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0D6EFD),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {},
              child: const Text('Kirim Pengajuan', style: TextStyle(color: Colors.white, fontSize: 16)),
            )
          ],
        ),
      ),
    );
  }
}

class LaporanScreen extends StatelessWidget {
  const LaporanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Form Laporan', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF0D6EFD))),
            const SizedBox(height: 20),
            const Text('Pilih Jenis Laporan', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
              value: 'Laporan Fasilitas Umum',
              items: ['Laporan Fasilitas Umum', 'Laporan Keamanan', 'Laporan Kebersihan'].map((String value) {
                return DropdownMenuItem<String>(value: value, child: Text(value));
              }).toList(),
              onChanged: (_) {},
            ),
            const SizedBox(height: 20),
            const Text('Tujuan / Keperluan', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            TextField(
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Contoh: Jembatan RT 13 Sudah mau\nRoboh.....',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0D6EFD),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {},
              child: const Text('Kirim Laporan', style: TextStyle(color: Colors.white, fontSize: 16)),
            )
          ],
        ),
      ),
    );
  }
}