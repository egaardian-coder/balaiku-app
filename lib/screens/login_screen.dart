import 'package:flutter/material.dart';
import 'main_layout.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 30),
              // Logo Utama Login yang Besar
              Image.asset('assets/images/Balaiku.png', height: 120, fit: BoxFit.contain),
              const SizedBox(height: 25),
              const Text('Selamat Datang', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              const Text('Masuk atau Daftar untuk\nmengakses akun Anda', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey, fontSize: 14)),
              const SizedBox(height: 25),
              const TabBar(
                labelColor: Color(0xFF185ABD),
                unselectedLabelColor: Colors.grey,
                indicatorColor: Color(0xFF185ABD),
                indicatorWeight: 3, // Garis tab lebih tebal sesuai mockup
                tabs: [Tab(text: 'Login'), Tab(text: 'Daftar')],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    _buildLoginTab(context),
                    _buildRegisterTab(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginTab(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        children: [
          TextField(decoration: InputDecoration(labelText: 'Nomor Telephone', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)))),
          const SizedBox(height: 20),
          TextField(obscureText: true, decoration: InputDecoration(labelText: 'Password', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)))),
          Align(alignment: Alignment.centerRight, child: TextButton(onPressed: (){}, child: const Text('Forgot password?', style: TextStyle(color: Color(0xFF185ABD))))),
          const SizedBox(height: 15),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF185ABD), minimumSize: const Size(double.infinity, 55), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
            onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MainLayout())),
            child: const Text('Login', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 30),
          const Text("By signing in with an account, you agree to SO's\nTerms of Service and Privacy Policy.", textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildRegisterTab(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        children: [
          TextField(decoration: InputDecoration(labelText: 'NIK', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)))),
          const SizedBox(height: 15),
          TextField(decoration: InputDecoration(labelText: 'Nomor Telephone', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)))),
          const SizedBox(height: 15),
          TextField(decoration: InputDecoration(labelText: 'Alamat', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)))),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(child: TextField(decoration: InputDecoration(labelText: 'RT', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))))),
              const SizedBox(width: 15),
              Expanded(child: TextField(decoration: InputDecoration(labelText: 'RW', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))))),
            ],
          ),
          const SizedBox(height: 15),
          TextField(obscureText: true, decoration: InputDecoration(labelText: 'Password', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)))),
          const SizedBox(height: 25),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF185ABD), minimumSize: const Size(double.infinity, 55), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
            onPressed: () {},
            child: const Text('Daftar', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}