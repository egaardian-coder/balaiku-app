import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main_layout.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controller untuk Tab Login
  final loginNikCtrl = TextEditingController();
  final loginPassCtrl = TextEditingController();

  // Controller untuk Tab Daftar (Sekarang lengkap dengan Nama)
  final regNikCtrl = TextEditingController();
  final regNamaCtrl = TextEditingController(); // TAMBAHAN: Controller Nama
  final regTelpCtrl = TextEditingController();
  final regAlamatCtrl = TextEditingController();
  final regRtCtrl = TextEditingController();
  final regRwCtrl = TextEditingController();
  final regPassCtrl = TextEditingController();

  Future<void> _prosesLogin() async {
    if (loginNikCtrl.text.isEmpty || loginPassCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('NIK dan Password wajib diisi!')),
      );
      return;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedNik = prefs.getString('nik_warga');
    String? savedPass = prefs.getString('password_warga');

    if (loginNikCtrl.text == savedNik && loginPassCtrl.text == savedPass) {
      await prefs.setBool('isLoggedIn', true);
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainLayout()),
      );
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('NIK atau Password salah!')));
    }
  }

  Future<void> _prosesDaftar() async {
    if (regNikCtrl.text.isEmpty ||
        regNamaCtrl.text.isEmpty ||
        regTelpCtrl.text.isEmpty ||
        regAlamatCtrl.text.isEmpty ||
        regPassCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Harap lengkapi semua form pendaftaran!')),
      );
      return;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Menyimpan data lengkap ke memori HP
    await prefs.setString('nik_warga', regNikCtrl.text);
    await prefs.setString('nama_warga', regNamaCtrl.text); // Menyimpan nama
    await prefs.setString('telp_warga', regTelpCtrl.text);
    // Menyimpan alamat dengan format rapi
    await prefs.setString(
      'alamat_warga',
      '${regAlamatCtrl.text}, RT ${regRtCtrl.text}/RW ${regRwCtrl.text}',
    );
    await prefs.setString('password_warga', regPassCtrl.text);

    if (!mounted) return;

    // Kosongkan form
    regNikCtrl.clear();
    regNamaCtrl.clear();
    regTelpCtrl.clear();
    regAlamatCtrl.clear();
    regRtCtrl.clear();
    regRwCtrl.clear();
    regPassCtrl.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Pendaftaran berhasil! Silakan geser ke tab Login.'),
      ),
    );
  }

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
              Image.asset(
                'assets/images/balaikubg.png',
                height: 100,
                fit: BoxFit.contain,
                errorBuilder: (c, e, s) =>
                    const Icon(Icons.apartment, size: 80, color: Colors.blue),
              ),
              const SizedBox(height: 15),
              const Text(
                'Selamat Datang',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              const Text(
                'Masuk atau Daftar untuk\nmengakses akun Anda',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              const SizedBox(height: 20),
              const TabBar(
                labelColor: Color(0xFF185ABD),
                unselectedLabelColor: Colors.grey,
                indicatorColor: Color(0xFF185ABD),
                indicatorWeight: 3,
                tabs: [
                  Tab(text: 'Login'),
                  Tab(text: 'Daftar'),
                ],
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
          TextField(
            controller: loginNikCtrl,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'NIK',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: loginPassCtrl,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 25),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF185ABD),
              minimumSize: const Size(double.infinity, 55),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: _prosesLogin,
            child: const Text(
              'Login',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegisterTab(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        children: [
          TextField(
            controller: regNikCtrl,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'NIK',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 15),
          // TAMBAHAN: Input Nama Lengkap
          TextField(
            controller: regNamaCtrl,
            decoration: InputDecoration(
              labelText: 'Nama Lengkap',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 15),
          TextField(
            controller: regTelpCtrl,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              labelText: 'Nomor Telephone',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 15),
          TextField(
            controller: regAlamatCtrl,
            decoration: InputDecoration(
              labelText: 'Alamat (Nama Jalan/Desa)',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: regRtCtrl,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'RT',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: TextField(
                  controller: regRwCtrl,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'RW',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          TextField(
            controller: regPassCtrl,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 25),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF185ABD),
              minimumSize: const Size(double.infinity, 55),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: _prosesDaftar,
            child: const Text(
              'Daftar',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
