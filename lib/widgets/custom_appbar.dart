import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading:
          true, // Memunculkan tombol back otomatis jika ada
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      toolbarHeight: 100, // Memberikan ruang lega untuk logo di tengah atas
      title: Image.asset(
        'assets/images/balaikubg.png',
        height: 85, // Ukuran proporsional untuk header
        fit: BoxFit.contain,
        errorBuilder: (c, e, s) => const Text(
          'BalaiKu',
          style: TextStyle(
            color: Color(0xFF185ABD),
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
