import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() => runApp(const BalaiKuApp());

class BalaiKuApp extends StatelessWidget {
  const BalaiKuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF185ABD),
        // Menggunakan kode warna dari Figma Anda
        scaffoldBackgroundColor: const Color(0xFFEAF5FD),
        fontFamily: 'Poppins',
        appBarTheme: const AppBarTheme(
          backgroundColor:
              Colors.transparent, // Transparan agar warna EAF5FD tembus ke atas
          elevation: 0,
          scrolledUnderElevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
