import 'package:flutter/material.dart';
import '../widgets/custom_appbar.dart';
import '../helpers/database_helper.dart';
import 'main_layout.dart'; // Penting: Import MainLayout di sini

class SuratScreen extends StatefulWidget {
  const SuratScreen({super.key});

  @override
  State<SuratScreen> createState() => _SuratScreenState();
}

class _SuratScreenState extends State<SuratScreen> {
  String selectedJenis = 'Surat Pengantar RT/RW';
  final keperluanCtrl = TextEditingController();

  Future<void> _kirimSurat() async {
    if (keperluanCtrl.text.isEmpty) return;

    await DatabaseHelper.instance.insertSurat({
      'jenis_surat': selectedJenis,
      'keperluan': keperluanCtrl.text,
      'tanggal': DateTime.now().toString(),
      'status': 'Proses'
    });

    if (!mounted) return;
    keperluanCtrl.clear();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Pengajuan Surat berhasil dikirim!')));
    
    // Melompat otomatis ke tab Riwayat (index 1)
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const MainLayout(initialIndex: 1)),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Pelayanan Surat', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF185ABD))),
            const SizedBox(height: 20),
            const Text('Pilih Jenis Surat', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)), filled: true, fillColor: Colors.white),
              value: selectedJenis,
              items: ['Surat Pengantar RT/RW', 'Surat Keterangan Usaha', 'Surat Keterangan Pindah'].map((String value) {
                return DropdownMenuItem<String>(value: value, child: Text(value));
              }).toList(),
              onChanged: (val) => setState(() => selectedJenis = val!),
            ),
            const SizedBox(height: 20),
            const Text('Tujuan / Keperluan', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            TextField(
              controller: keperluanCtrl,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Contoh: Mengurus Pendaftaran\nSekolah',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                filled: true, fillColor: Colors.white
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF185ABD),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: _kirimSurat,
              child: const Text('Kirim Pengajuan', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            )
          ],
        ),
      ),
    );
  }
}

class LaporanScreen extends StatefulWidget {
  const LaporanScreen({super.key});

  @override
  State<LaporanScreen> createState() => _LaporanScreenState();
}

class _LaporanScreenState extends State<LaporanScreen> {
  String selectedJenis = 'Laporan Fasilitas Umum';
  final deskripsiCtrl = TextEditingController();

  Future<void> _kirimLaporan() async {
    if (deskripsiCtrl.text.isEmpty) return;

    await DatabaseHelper.instance.insertLaporan({
      'jenis_laporan': selectedJenis,
      'deskripsi': deskripsiCtrl.text,
      'tanggal': DateTime.now().toString(),
      'status': 'Proses'
    });

    if (!mounted) return;
    deskripsiCtrl.clear();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Laporan Anda berhasil dikirim ke Dasbor Desa!')));
    
    // Melompat otomatis ke tab Riwayat (index 1)
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const MainLayout(initialIndex: 1)),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Form Laporan', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF185ABD))),
            const SizedBox(height: 20),
            const Text('Pilih Jenis Laporan', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)), filled: true, fillColor: Colors.white),
              value: selectedJenis,
              items: ['Laporan Fasilitas Umum', 'Laporan Keamanan', 'Laporan Kebersihan'].map((String value) {
                return DropdownMenuItem<String>(value: value, child: Text(value));
              }).toList(),
              onChanged: (val) => setState(() => selectedJenis = val!),
            ),
            const SizedBox(height: 20),
            const Text('Deskripsi / Detail Laporan', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            TextField(
              controller: deskripsiCtrl,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Contoh: Jembatan RT 13 Sudah mau\nRoboh.....',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                filled: true, fillColor: Colors.white
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF185ABD),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: _kirimLaporan,
              child: const Text('Kirim Laporan', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            )
          ],
        ),
      ),
    );
  }
}