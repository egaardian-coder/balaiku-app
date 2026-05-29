import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

/// =======================================================
/// MAIN APP
/// =======================================================
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BalaiKu',
      theme: ThemeData(fontFamily: 'Poppins'),
      home: const SplashScreen(),
    );
  }
}

/// =======================================================
/// SPLASH SCREEN
/// =======================================================
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AuthPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDDE6EF),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Icon(Icons.home_work_rounded, size: 140, color: Colors.blue[700]),

            const SizedBox(height: 10),

            Text(
              "BalaiKu",
              style: TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.bold,
                color: Colors.blue[700],
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              "LAYANAN DESA DIGITAL",
              style: TextStyle(letterSpacing: 1, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}

/// =======================================================
/// AUTH PAGE
/// =======================================================
class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDDE6EF),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30),

              /// TITLE
              const Text(
                "Selamat Datang",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 5),

              const Text(
                "Masuk atau Daftar untuk\nmengakses akun Anda",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black54),
              ),

              const SizedBox(height: 30),

              /// TAB
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),

                child: Container(
                  height: 50,

                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                  ),

                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isLogin = true;
                            });
                          },

                          child: Container(
                            decoration: BoxDecoration(
                              color:
                                  isLogin ? Colors.white : Colors.transparent,

                              borderRadius: BorderRadius.circular(12),
                            ),

                            child: const Center(
                              child: Text(
                                "Login",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),

                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isLogin = false;
                            });
                          },

                          child: Container(
                            decoration: BoxDecoration(
                              color:
                                  !isLogin ? Colors.white : Colors.transparent,

                              borderRadius: BorderRadius.circular(12),
                            ),

                            child: const Center(
                              child: Text(
                                "Daftar",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              Icon(Icons.home_work_rounded, size: 90, color: Colors.blue[700]),

              Text(
                "BalaiKu",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[700],
                ),
              ),

              const SizedBox(height: 30),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),

                child: Column(
                  children: [
                    if (isLogin) ...[
                      buildTextField(
                        hint: "Nomor Telephone",
                        icon: Icons.phone_outlined,
                      ),

                      const SizedBox(height: 15),

                      buildTextField(
                        hint: "Password",
                        icon: Icons.lock_outline,
                        isPassword: true,
                      ),

                      const SizedBox(height: 10),

                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Forgot password?",
                          style: TextStyle(fontSize: 12),
                        ),
                      ),

                      const SizedBox(height: 25),

                      SizedBox(
                        width: double.infinity,
                        height: 52,

                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MainNavigation(),
                              ),
                            );
                          },

                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1495FF),

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),

                          child: const Text(
                            "Login",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],

                    /// REGISTER
                    if (!isLogin) ...[
                      buildTextField(hint: "NIK", icon: Icons.badge_outlined),

                      const SizedBox(height: 15),

                      buildTextField(
                        hint: "Nomor Telephone",
                        icon: Icons.phone_outlined,
                      ),

                      const SizedBox(height: 15),

                      Row(
                        children: [
                          Expanded(
                            child: buildTextField(
                              hint: "RT",
                              icon: Icons.home_outlined,
                            ),
                          ),

                          const SizedBox(width: 10),

                          Expanded(
                            child: buildTextField(
                              hint: "RW",
                              icon: Icons.home_work_outlined,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 15),

                      buildTextField(
                        hint: "Alamat",
                        icon: Icons.location_on_outlined,
                      ),

                      const SizedBox(height: 15),

                      buildTextField(
                        hint: "Password",
                        icon: Icons.lock_outline,
                        isPassword: true,
                      ),

                      const SizedBox(height: 25),

                      SizedBox(
                        width: double.infinity,
                        height: 52,

                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isLogin = true;
                            });
                          },

                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1495FF),

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),

                          child: const Text(
                            "Daftar",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],

                    const SizedBox(height: 25),

                    const Text(
                      "By signing in with an account, you agree to SO's\nTerms of Service and Privacy Policy",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 10, color: Colors.black45),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField({
    required String hint,
    required IconData icon,
    bool isPassword = false,
  }) {
    return TextField(
      obscureText: isPassword,

      decoration: InputDecoration(
        hintText: hint,

        prefixIcon: Icon(icon),

        suffixIcon:
            isPassword ? const Icon(Icons.visibility_off_outlined) : null,

        filled: true,
        fillColor: Colors.white,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

/// =======================================================
/// MAIN NAVIGATION
/// =======================================================
class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int currentIndex = 0;

  final List<Widget> pages = [
    const HomePage(),
    const RiwayatPage(),
    const SOSPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,

        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Beranda",
          ),

          BottomNavigationBarItem(icon: Icon(Icons.history), label: "Riwayat"),

          BottomNavigationBarItem(icon: Icon(Icons.sos_outlined), label: "SOS"),

          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}

/// =======================================================
/// HOME PAGE
/// =======================================================
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDDE6EF),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// HEADER
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),

                decoration: const BoxDecoration(
                  color: Color(0xFF1495FF),

                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),

                child: Column(
                  children: [
                    /// SEARCH
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),

                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),

                      child: const TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          icon: Icon(Icons.search),
                          hintText: "Telusuri lokasi",
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    /// PROFILE CARD
                    Container(
                      padding: const EdgeInsets.all(12),

                      decoration: BoxDecoration(
                        color: const Color(0xFF1976D2),
                        borderRadius: BorderRadius.circular(18),
                      ),

                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 26,
                            backgroundImage: NetworkImage(
                              "https://i.pravatar.cc/300",
                            ),
                          ),

                          const SizedBox(width: 12),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                const Text(
                                  "Warga Terdaftar",
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 11,
                                  ),
                                ),

                                const SizedBox(height: 3),

                                const Text(
                                  "Ega Ardian",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(height: 5),

                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),

                                  decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(20),
                                  ),

                                  child: const Text(
                                    "Kerja Bakti Hari Minggu jam 08:00 WIB",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 9,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),

                            decoration: BoxDecoration(
                              color: Colors.white24,
                              borderRadius: BorderRadius.circular(20),
                            ),

                            child: const Text(
                              "RT 01 RW 02",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// MENU
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    menuButton(
                      context,
                      Icons.mail_outline,
                      "Buat Surat",
                      const PelayananSuratPage(),
                    ),

                    menuButton(
                      context,
                      Icons.assignment_outlined,
                      "Form Laporan",
                      const FormLaporanPage(),
                    ),

                    menuButton(
                      context,
                      Icons.storefront_outlined,
                      "Pasar Warga",
                      const PasarWargaPage(),
                    ),

                    menuButton(
                      context,
                      Icons.people_outline,
                      "Daftar Warga",
                      const DaftarWargaPage(),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: const [
                    Text(
                      "Aktivitas Terakhir",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),

                    Text("Lihat Semua", style: TextStyle(color: Colors.blue)),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              activityCard(),

              const SizedBox(height: 40),

              Icon(Icons.home_work_rounded, size: 140, color: Colors.blue[200]),

              Text(
                "BalaiKu",
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[200],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget menuButton(
    BuildContext context,
    IconData icon,
    String title,
    Widget page,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },

      child: Column(
        children: [
          Container(
            width: 65,
            height: 65,

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),

            child: Icon(icon, color: Colors.orange),
          ),

          const SizedBox(height: 8),

          SizedBox(
            width: 70,

            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }

  static Widget activityCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.all(10),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(blurRadius: 5, color: Colors.black12)],
      ),

      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,

            decoration: BoxDecoration(
              color: Colors.orange[100],
              borderRadius: BorderRadius.circular(12),
            ),

            child: const Icon(Icons.mail, color: Colors.orange),
          ),

          const SizedBox(width: 12),

          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  "Surat Keterangan Pindah",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),

                SizedBox(height: 5),

                Text(
                  "12 Mei 2026 | 14:30 WIB",
                  style: TextStyle(fontSize: 11, color: Colors.grey),
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),

            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(20),
            ),

            child: const Text(
              "Selesai",
              style: TextStyle(color: Colors.white, fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }
}

/// =======================================================
/// PELAYANAN SURAT
/// =======================================================
class PelayananSuratPage extends StatelessWidget {
  const PelayananSuratPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDDE6EF),

      appBar: AppBar(
        backgroundColor: const Color(0xFF1495FF),
        title: const Text("Pelayanan Surat"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(15),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const Text("Pilih Jenis Surat"),

            const SizedBox(height: 10),

            DropdownButtonFormField(
              items: const [
                DropdownMenuItem(
                  value: "1",
                  child: Text("Surat Pengantar RT/RW"),
                ),
              ],

              onChanged: (value) {},
            ),

            const SizedBox(height: 20),

            const Text("Tujuan / Keperluan"),

            const SizedBox(height: 10),

            TextField(
              maxLines: 5,

              decoration: InputDecoration(
                hintText: "Contoh: Mengurus Pendaftaran Sekolah ...",

                filled: true,
                fillColor: Colors.white,

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// =======================================================
/// FORM LAPORAN
/// =======================================================
class FormLaporanPage extends StatelessWidget {
  const FormLaporanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDDE6EF),

      appBar: AppBar(
        backgroundColor: const Color(0xFF1495FF),
        title: const Text("Form Laporan"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(15),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const Text("Pilih Jenis Laporan"),

            const SizedBox(height: 10),

            DropdownButtonFormField(
              items: const [
                DropdownMenuItem(
                  value: "1",
                  child: Text("Surat Pengantar RT/RW"),
                ),
              ],

              onChanged: (value) {},
            ),

            const SizedBox(height: 20),

            const Text("Tujuan / Keperluan"),

            const SizedBox(height: 10),

            TextField(
              maxLines: 5,

              decoration: InputDecoration(
                hintText: "Contoh: Jembatan RT 13 Sudah mau Roboh....",

                filled: true,
                fillColor: Colors.white,

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// =======================================================
/// PASAR WARGA
/// =======================================================
class PasarWargaPage extends StatelessWidget {
  const PasarWargaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDDE6EF),

      appBar: AppBar(
        backgroundColor: const Color(0xFF1495FF),
        title: const Text("Pasar Warga"),
      ),

      body: ListView(
        padding: const EdgeInsets.all(15),

        children: [
          productCard("Kipas Dinding Arashi", "Rp. 120.000", Icons.toys),

          const SizedBox(height: 15),

          productCard("Play Station 5", "Rp. 120.000", Icons.sports_esports),
        ],
      ),
    );
  }

  Widget productCard(String title, String price, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),

      child: Column(
        children: [
          Icon(icon, size: 120, color: Colors.grey),

          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 8,
                ),

                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(12),
                ),

                child: Text(price, style: const TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// =======================================================
/// DAFTAR WARGA
/// =======================================================
class DaftarWargaPage extends StatelessWidget {
  const DaftarWargaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDDE6EF),

      appBar: AppBar(
        backgroundColor: const Color(0xFF1495FF),
        title: const Text("Daftar Warga"),
      ),

      body: ListView(
        padding: const EdgeInsets.all(15),

        children: [wargaCard("RT 01 RW 02"), wargaCard("RT 03 RW 02")],
      ),
    );
  }

  Widget wargaCard(String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(12),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),

          const SizedBox(height: 10),

          wargaItem("Keluarga Jaylani"),
          wargaItem("Keluarga Joylan"),
          wargaItem("Keluarga Jefri"),
          wargaItem("Keluarga Mulyadi"),
        ],
      ),
    );
  }

  Widget wargaItem(String name) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),

      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [Text(name), const Icon(Icons.arrow_forward_ios, size: 16)],
      ),
    );
  }
}

/// =======================================================
/// RIWAYAT
/// =======================================================
class RiwayatPage extends StatelessWidget {
  const RiwayatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDDE6EF),

      appBar: AppBar(
        backgroundColor: const Color(0xFF1495FF),
        title: const Text("Riwayat"),
      ),

      body: Column(
        children: [
          const SizedBox(height: 15),

          Row(
            children: [
              const SizedBox(width: 15),

              chip("Proses"),
              const SizedBox(width: 10),
              chip("Selesai"),
            ],
          ),

          const SizedBox(height: 15),

          HomePage.activityCard(),
        ],
      ),
    );
  }

  Widget chip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),

      decoration: BoxDecoration(
        color: text == "Selesai" ? Colors.blue : Colors.white,

        borderRadius: BorderRadius.circular(20),
      ),

      child: Text(
        text,
        style: TextStyle(
          color: text == "Selesai" ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}

/// =======================================================
/// SOS PAGE
/// =======================================================
class SOSPage extends StatefulWidget {
  const SOSPage({super.key});

  @override
  State<SOSPage> createState() => _SOSPageState();
}

class _SOSPageState extends State<SOSPage> {
  bool reported = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,

      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              const Icon(
                Icons.notifications_active,
                size: 130,
                color: Colors.black,
              ),

              const SizedBox(height: 25),

              const Text(
                "LAPOR DARURAT",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "Peringatan dan lokasi Anda sedang dipancarkan\nke Dasbor Keamanan Desa.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),

              const SizedBox(height: 35),

              if (!reported)
                SizedBox(
                  width: 260,
                  height: 55,

                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        reported = true;
                      });
                    },

                    child: const Text("LAPOR"),
                  ),
                ),

              if (reported) ...[
                Container(
                  width: 280,
                  padding: const EdgeInsets.all(20),

                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),

                    borderRadius: BorderRadius.circular(15),
                  ),

                  child: const Column(
                    children: [
                      Text(
                        "Lokasi Saat Ini",
                        style: TextStyle(color: Colors.white),
                      ),

                      SizedBox(height: 8),

                      Text(
                        "Jl. Pramuka, Bandar Lampung",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                SizedBox(
                  width: 260,
                  height: 55,

                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        reported = false;
                      });
                    },

                    child: const Text("BATALKAN LAPORAN"),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// =======================================================
/// PROFILE PAGE
/// =======================================================
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDDE6EF),

      appBar: AppBar(
        backgroundColor: const Color(0xFF1495FF),
        title: const Text("Profile"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            const SizedBox(height: 20),

            const CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage("https://i.pravatar.cc/300"),
            ),

            const SizedBox(height: 20),

            const Text(
              "Ega Ardian",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            const Text(
              "egaardian@gmail.com",
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 30),

            profileMenu(Icons.person, "Data Diri"),
            profileMenu(Icons.lock, "Ubah Password"),
            profileMenu(Icons.settings, "Pengaturan"),
            profileMenu(Icons.logout, "Logout"),
          ],
        ),
      ),
    );
  }

  Widget profileMenu(IconData icon, String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),

      child: Row(
        children: [
          Icon(icon),

          const SizedBox(width: 15),

          Expanded(child: Text(title)),

          const Icon(Icons.arrow_forward_ios),
        ],
      ),
    );
  }
}
