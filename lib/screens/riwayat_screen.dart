import 'package:flutter/material.dart';
import '../helpers/database_helper.dart';
import '../widgets/custom_appbar.dart';

class RiwayatScreen extends StatefulWidget {
  const RiwayatScreen({Key? key}) : super(key: key);

  @override
  State<RiwayatScreen> createState() => _RiwayatScreenState();
}

class _RiwayatScreenState extends State<RiwayatScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFFF3F8FE),
        appBar: const CustomAppBar(),
        body: Column(
          children: [
            const SizedBox(height: 10),
            const TabBar(
              labelColor: Color(0xFF0094FF),
              unselectedLabelColor: Colors.grey,
              indicatorColor: Color(0xFF0094FF),
              labelStyle: TextStyle(fontWeight: FontWeight.bold),
              tabs: [
                Tab(text: 'Riwayat Surat'),
                Tab(text: 'Riwayat Laporan'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [_buildDaftarSurat(), _buildDaftarLaporan()],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDaftarSurat() {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: DatabaseHelper.instance.getAllSurat(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text(
              'Belum ada riwayat pengajuan surat.',
              style: TextStyle(color: Colors.grey),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(15),
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            final item = snapshot.data![index];
            String status = item['status'] ?? 'Proses';

            Color statusColor = Colors.orange;
            if (status == 'Selesai') statusColor = const Color(0xFF00E676);
            if (status == 'Ditolak') statusColor = Colors.red;

            String tanggalRaw = item['tanggal'] ?? '';
            String tanggalTampil = tanggalRaw.length > 16
                ? tanggalRaw.substring(0, 16)
                : tanggalRaw;

            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFFE3F2FD),
                  child: Icon(Icons.mail, color: Color(0xFF0094FF)),
                ),
                title: Text(
                  item['jenis_surat'] ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Text(
                      'Keperluan: ${item['keperluan'] ?? ''}',
                      style: const TextStyle(fontSize: 13),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      tanggalTampil,
                      style: const TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                  ],
                ),
                // =======================================================
                // INI ADALAH TOMBOL HAPUS (IKON SAMPAH MERAH DI KANAN)
                // =======================================================
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        status,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.redAccent),
                      onPressed: () async {
                        bool? konfirmasi = await _tampilkanDialogHapus();
                        if (konfirmasi == true) {
                          await DatabaseHelper.instance.deleteSurat(item['id']);
                          setState(
                            () {},
                          ); // Untuk menyegarkan halaman setelah dihapus
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildDaftarLaporan() {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: DatabaseHelper.instance.getAllLaporan(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text(
              'Belum ada riwayat laporan warga.',
              style: TextStyle(color: Colors.grey),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(15),
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            final item = snapshot.data![index];
            String status = item['status'] ?? 'Proses';

            Color statusColor = Colors.orange;
            if (status == 'Selesai') statusColor = const Color(0xFF00E676);
            if (status == 'Ditolak') statusColor = Colors.red;

            String tanggalRaw = item['tanggal'] ?? '';
            String tanggalTampil = tanggalRaw.length > 16
                ? tanggalRaw.substring(0, 16)
                : tanggalRaw;

            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFFFFF3E0),
                  child: Icon(Icons.assignment, color: Colors.orange),
                ),
                title: Text(
                  item['jenis_laporan'] ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Text(
                      'Detail: ${item['deskripsi'] ?? ''}',
                      style: const TextStyle(fontSize: 13),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      tanggalTampil,
                      style: const TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                  ],
                ),
                // =======================================================
                // INI ADALAH TOMBOL HAPUS (IKON SAMPAH MERAH DI KANAN)
                // =======================================================
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        status,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.redAccent),
                      onPressed: () async {
                        bool? konfirmasi = await _tampilkanDialogHapus();
                        if (konfirmasi == true) {
                          await DatabaseHelper.instance.deleteLaporan(
                            item['id'],
                          );
                          setState(
                            () {},
                          ); // Untuk menyegarkan halaman setelah dihapus
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  // Jendela Pop-up Konfirmasi Hapus
  Future<bool?> _tampilkanDialogHapus() {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Riwayat'),
        content: const Text(
          'Apakah Anda yakin ingin menghapus riwayat aktivitas ini?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Hapus', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
