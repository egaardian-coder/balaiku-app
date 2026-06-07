import 'package:flutter/material.dart';
import 'login_screen.dart'; 

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Profil Saya', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Center(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFF0D6EFD), width: 3),
                    ),
                    child: const CircleAvatar(
                      radius: 50,
                      backgroundColor: Color(0x1A0D6EFD), 
                      child: Text(
                        'DN', 
                        style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Color(0xFF0D6EFD)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text('Darwin Nainggolan', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  const Text('NIK: 1871xxxxxxxxxxxx', style: TextStyle(color: Colors.grey, fontSize: 14)),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0x1A0D6EFD),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Warga Terdaftar - RT 01 RW 02', 
                      style: TextStyle(color: Color(0xFF0D6EFD), fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),

            _buildProfileMenu(Icons.person_outline, 'Edit Informasi Data Diri', () {}),
            _buildProfileMenu(Icons.lock_outline, 'Keamanan & Ganti Password', () {}),
            _buildProfileMenu(Icons.help_outline, 'Pusat Bantuan Desa', () {}),
            _buildProfileMenu(Icons.info_outline, 'Tentang Aplikasi BalaiKu', () {}),

            const SizedBox(height: 30),
            
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade50,
                foregroundColor: Colors.red,
                minimumSize: const Size(double.infinity, 55),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                elevation: 0,
              ),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false,
                );
              },
              icon: const Icon(Icons.logout),
              label: const Text('Keluar Akun', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileMenu(IconData icon, String title, VoidCallback onTap) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0x1A0D6EFD), 
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: const Color(0xFF0D6EFD)),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }
}