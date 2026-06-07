import 'package:flutter/material.dart';

class SosScreen extends StatelessWidget {
  const SosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('LAPOR DARURAT', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold))),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(color: Colors.red.withOpacity(0.1), shape: BoxShape.circle),
                child: const Icon(Icons.campaign, color: Colors.red, size: 120), 
              ),
              const SizedBox(height: 30),
              const Text('LAPOR DARURAT', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.red)),
              const SizedBox(height: 10),
              const Text(
                'Peringatan dan lokasi Anda sedang dipancarkan\nke Dasbor Keamanan Desa.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.grey.shade300)),
                child: const Column(
                  children: [
                    Text('Lokasi Saat ini', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 5),
                    Text('Jl. Pramuka, Bandar Lampung', style: TextStyle(color: Colors.grey)),
                    Text('11 Mei 2026, 08:00 WIB', style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red, minimumSize: const Size(double.infinity, 50), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                onPressed: () {},
                child: const Text('BATALKAN LAPORAN', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
              )
            ],
          ),
        ),
      ),
    );
  }
}