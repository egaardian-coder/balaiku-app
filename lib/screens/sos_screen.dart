import 'package:flutter/material.dart';
import '../widgets/custom_appbar.dart';
import 'sos_alert_screen.dart'; // Pastikan file ini sudah ada

class SosScreen extends StatefulWidget {
  const SosScreen({super.key});

  @override
  State<SosScreen> createState() => _SosScreenState();
}

class _SosScreenState extends State<SosScreen> {
  bool isLaporPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.campaign,
                  color: isLaporPressed ? Colors.red : Colors.grey,
                  size: 120,
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'LAPOR DARURAT',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Peringatan dan lokasi Anda sedang dipancarkan\nke Dasbor Keamanan Desa.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 30),

              if (isLaporPressed) ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: const Column(
                    children: [
                      Text(
                        'Lokasi Saat ini',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Jl. Pramuka, Bandar Lampung',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(
                        '11 Mei 2026, 08:00 WIB',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
              ],

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isLaporPressed
                      ? Colors.red
                      : const Color(0xFF0D6EFD),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    isLaporPressed = !isLaporPressed;
                  });

                  // JIKA LAPOR DITEKAN, BUKA LAYAR MERAH PENUH
                  if (isLaporPressed) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SosAlertScreen(
                          namaPelapor: 'Darwin Nainggolan',
                          lokasiPalsu: 'Jl. Pramuka, Bandar Lampung',
                          waktu: '11 Mei 2026, 08:00 WIB',
                        ),
                      ),
                    );
                  }
                },
                child: Text(
                  isLaporPressed ? 'BATALKAN LAPORAN' : 'LAPOR',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
