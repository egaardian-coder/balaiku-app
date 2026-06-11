import 'package:flutter/material.dart';

class SosAlertScreen extends StatelessWidget {
  final String namaPelapor;
  final String lokasiPalsu;
  final String waktu;

  const SosAlertScreen({
    Key? key,
    required this.namaPelapor,
    required this.lokasiPalsu,
    required this.waktu,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // BACKGROUND WARNA MERAH TERANG SEPERTI PERMINTAANMU
      backgroundColor: Colors.red[700],
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Ikon sirine/toa berkedip (simulasi)
                Container(
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.campaign,
                    size: 80,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(height: 30),

                const Text(
                  'DARURAT!',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 10),

                Text(
                  '$namaPelapor membutuhkan bantuan segera!',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
                const SizedBox(height: 40),

                // Kotak Lokasi
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Lokasi Saat Ini',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        lokasiPalsu,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        waktu,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 50),

                // Tombol Tutup (Untuk menyembunyikan peringatan)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.red,
                    minimumSize: const Size(double.infinity, 55),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    // Tutup layar merah ini
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'SAYA MENGERTI / TUTUP ALARM',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
