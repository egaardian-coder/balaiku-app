import 'package:flutter/material.dart';
import '../helpers/database_helper.dart';
import '../widgets/custom_appbar.dart';

class RiwayatScreen extends StatefulWidget {
  const RiwayatScreen({super.key});

  @override
  State<RiwayatScreen> createState() => _RiwayatScreenState();
}

class _RiwayatScreenState extends State<RiwayatScreen> {
  List<Map<String, dynamic>> riwayatProses = [];
  List<Map<String, dynamic>> riwayatSelesai = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRiwayatData();
  }

  Future<void> _loadRiwayatData() async {
    final proses = await DatabaseHelper.instance.getRiwayat('Proses');
    var selesai = await DatabaseHelper.instance.getRiwayat('Selesai');

    if (selesai.isEmpty) {
      selesai = [{
        'judul': 'Surat Keterangan Pindah',
        'tanggal': '12 Mei 2026 | 14:30 WIB',
        'status': 'Selesai',
        'tipe': 'surat'
      }];
    }

    setState(() {
      riwayatProses = proses;
      riwayatSelesai = selesai;
      isLoading = false;
    });
  }

  String _formatTanggal(String tanggalAsli) {
    if (tanggalAsli.contains('|')) return tanggalAsli; 
    DateTime dt = DateTime.parse(tanggalAsli);
    return "${dt.day}-${dt.month}-${dt.year} | ${dt.hour}:${dt.minute.toString().padLeft(2, '0')} WIB";
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: const CustomAppBar(), 
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text('Riwayat Pengajuan', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF185ABD))),
            ),
            const TabBar(
              labelColor: Color(0xFF185ABD),
              unselectedLabelColor: Colors.grey,
              indicatorColor: Color(0xFF185ABD),
              indicatorWeight: 3,
              tabs: [Tab(text: 'Proses'), Tab(text: 'Selesai')],
            ),
            Expanded(
              child: isLoading 
                ? const Center(child: CircularProgressIndicator())
                : TabBarView(
                    children: [
                      _buildList(riwayatProses, isProses: true),
                      _buildList(riwayatSelesai, isProses: false),
                    ],
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildList(List<Map<String, dynamic>> items, {required bool isProses}) {
    if (items.isEmpty) {
      return Center(
        child: Text(
          isProses ? 'Belum ada pengajuan yang diproses.' : 'Belum ada riwayat selesai.',
          style: const TextStyle(color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(15),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        final isSurat = item['tipe'] == 'surat';

        return Card(
          elevation: 2,
          margin: const EdgeInsets.only(bottom: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10), side: BorderSide(color: Colors.grey.shade200)),
          child: ListTile(
            leading: Icon(
              isSurat ? Icons.mark_email_unread : Icons.description, 
              color: isProses ? Colors.orange : Colors.green, 
              size: 35
            ),
            title: Text(item['judul'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            subtitle: Text(_formatTanggal(item['tanggal']), style: const TextStyle(fontSize: 12)),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: isProses ? Colors.orange.shade100 : Colors.green.shade100, 
                borderRadius: BorderRadius.circular(20)
              ),
              child: Text(
                item['status'], 
                style: TextStyle(
                  color: isProses ? Colors.orange : Colors.green, 
                  fontSize: 12, 
                  fontWeight: FontWeight.bold
                )
              ),
            ),
          ),
        );
      },
    );
  }
}