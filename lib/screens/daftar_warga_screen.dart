import 'package:flutter/material.dart';
import '../widgets/custom_appbar.dart';

class DaftarWargaScreen extends StatelessWidget {
  const DaftarWargaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          const Text('Daftar Warga', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF0D6EFD))),
          const SizedBox(height: 15),
          _buildRTSection(context, 'RT 01 RW 02', 5),
          const SizedBox(height: 20),
          _buildRTSection(context, 'RT 03 RW 02', 4),
        ],
      ),
    );
  }

  Widget _buildRTSection(BuildContext context, String rtTitle, int count) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(5)),
          child: Text(rtTitle, style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 10),
        ...List.generate(count, (index) => Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Keluarga Jaylani', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: const Text('Jalan Imam Bonjol No. 12, Banjar Agung'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
                  builder: (context) => Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Detail Keluarga Jaylani', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0D6EFD))),
                        const Divider(),
                        const Text('Kepala Keluarga: Jaylani Umar'),
                        const Text('Jumlah Anggota: 4 Orang'),
                        Text('Alamat: $rtTitle, Jalan Imam Bonjol No. 12'),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0D6EFD), minimumSize: const Size(double.infinity, 45)),
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Tutup', style: TextStyle(color: Colors.white)),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
            if (index < count - 1) const Divider(height: 1),
          ],
        )),
      ],
    );
  }
}