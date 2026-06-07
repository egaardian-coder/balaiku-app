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
        primaryColor: const Color(0xFF0D6EFD),
        fontFamily: 'Poppins',
      ),
      home: const SplashScreen(),
    );
  }
}