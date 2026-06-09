import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      centerTitle: true,
      toolbarHeight: 140, // Tinggi dibuat ekstra besar
      backgroundColor: Colors.transparent, // Menyatu dengan warna background halaman
      elevation: 0,
      title: Image.asset(
        'assets/images/Balaiku.png', 
        height: 120, // Logo dibesarkan
        fit: BoxFit.contain,
        errorBuilder: (c, e, s) => const Text('BalaiKu', style: TextStyle(color: Color(0xFF185ABD), fontWeight: FontWeight.bold, fontSize: 32)),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(140);
}