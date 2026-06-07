import 'package:flutter/material.dart';

class RiwayatScreen extends StatelessWidget {
  const RiwayatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Riwayat', style: TextStyle(fontWeight: FontWeight.bold)),
          centerTitle: true,
          bottom: const TabBar(
            labelColor: Color(0xFF0D6EFD),
            unselectedLabelColor: Colors.grey,
            indicatorColor: Color(0xFF0D6EFD),
            tabs: [Tab(text: 'Proses'), Tab(text: 'Selesai')],
          ),
        ),
        body: TabBarView(
          children: [
            _buildList(isProses: true),
            _buildList(isProses: false),
          ],
        ),
      ),
    );
  }

  Widget _buildList({required bool isProses}) {
    return ListView(
      padding: const EdgeInsets.all(15),
      children: [
        if (!isProses)
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
          ),
        if (isProses)
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10), side: BorderSide(color: Colors.grey.shade200)),
            child: ListTile(
              leading: const Icon(Icons.mark_email_unread, color: Colors.orange, size: 35),
              title: const Text('Surat Keterangan Usaha', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              subtitle: const Text('20 Mei 2026 | 14:30 WIB'),
              trailing: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(color: Colors.orange.shade100, borderRadius: BorderRadius.circular(20)),
                child: const Text('Proses', style: TextStyle(color: Colors.orange, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
      ],
    );
  }
}