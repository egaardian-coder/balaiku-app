import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const BalaiKuApp());
}

class BalaiKuApp extends StatelessWidget {
  const BalaiKuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BalaiKu',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF0D6EFD),
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 1,
        ),
      ),
      home: const LoginScreen(),
    );
  }
}