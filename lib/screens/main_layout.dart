import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'riwayat_screen.dart';
import 'sos_screen.dart';
import 'profile_screen.dart';

class MainLayout extends StatefulWidget {
  final int initialIndex;
  const MainLayout({super.key, this.initialIndex = 0});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    // KUNCI PERBAIKAN: Daftar layar dipindah ke dalam build dan 'const' dihapus
    // agar Home dan Profile selalu memuat data terbaru setiap kali tab diklik.
    final List<Widget> screens = [
      HomeScreen(), // <-- Tanpa const
      const RiwayatScreen(),
      const SosScreen(),
      ProfileScreen(), // <-- Tanpa const
    ];

    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          currentIndex: _currentIndex,
          selectedItemColor: const Color(0xFF185ABD),
          unselectedItemColor: Colors.grey,
          elevation: 0,
          onTap: (index) => setState(() => _currentIndex = index),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'Riwayat',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.sos, color: Colors.red),
              label: 'SOS',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}
