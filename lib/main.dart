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
        // Menyesuaikan warna seluruh aplikasi dengan warna background logo
        scaffoldBackgroundColor: const Color(0xFFF4F7FC), 
        fontFamily: 'Poppins',
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent, // Dibuat transparan agar menyatu dengan scaffold
          elevation: 0,
          scrolledUnderElevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}