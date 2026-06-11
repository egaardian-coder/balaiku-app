import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String namaWarga = 'Memuat nama...';
  String nikWarga = '-';
  String telpWarga = '-';
  String alamatWarga = '-';
  String inisial = '??';

  @override
  void initState() {
    super.initState();
    _loadWargaData();
  }

  // 1. MEMBUAT DATA PROFIL DINAMIS DARI MEMORI HP
  Future<void> _loadWargaData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      namaWarga = prefs.getString('nama_warga') ?? 'Warga Balaiku';
      nikWarga = prefs.getString('nik_warga') ?? 'Belum terdaftar';
      telpWarga = prefs.getString('telp_warga') ?? '-';
      alamatWarga = prefs.getString('alamat_warga') ?? 'RT 00 RW 00';

      List<String> kata = namaWarga.trim().split(' ');
      if (kata.length > 1 && kata[0].isNotEmpty && kata[1].isNotEmpty) {
        inisial = '${kata[0][0]}${kata[1][0]}'.toUpperCase();
      } else if (kata.isNotEmpty && kata[0].isNotEmpty) {
        inisial = kata[0].substring(0, 1).toUpperCase();
      }
    });
  }

  // 2. FITUR UBAH FOTO PROFIL (SIMULASI MOCKUP)
  void _ubahFotoProfil() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Ubah Foto Profil',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(
                Icons.photo_library,
                color: Color(0xFF0D6EFD),
              ),
              title: const Text('Pilih dari Galeri'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Mengakses Galeri... (Memerlukan package image_picker)',
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Color(0xFF0D6EFD)),
              title: const Text('Ambil dari Kamera'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Mengakses Kamera... (Memerlukan package image_picker)',
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // 3. FITUR EDIT INFORMASI DATA DIRI (BISA DIUBAH LANGSUNG)
  void _showEditProfileDialog() {
    final nameCtrl = TextEditingController(text: namaWarga);
    final phoneCtrl = TextEditingController(text: telpWarga);
    final addressCtrl = TextEditingController(text: alamatWarga);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Edit Data Diri',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameCtrl,
                decoration: const InputDecoration(labelText: 'Nama Lengkap'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: phoneCtrl,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: 'No. Handphone'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: addressCtrl,
                decoration: const InputDecoration(
                  labelText: 'Alamat Domisili / RT RW',
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0D6EFD),
            ),
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setString('nama_warga', nameCtrl.text);
              await prefs.setString('telp_warga', phoneCtrl.text);
              await prefs.setString('alamat_warga', addressCtrl.text);

              _loadWargaData(); // Muat ulang layar secara realtime
              if (!mounted) return;
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Data berhasil diperbarui!')),
              );
            },
            child: const Text('Simpan', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // 4. FITUR KEAMANAN & GANTI PASSWORD
  void _showSecurityDialog() {
    final oldPassCtrl = TextEditingController();
    final newPassCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Ganti Password',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: oldPassCtrl,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password Lama'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: newPassCtrl,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password Baru'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0D6EFD),
            ),
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              String? savedPass = prefs.getString('password_warga');

              if (oldPassCtrl.text == savedPass) {
                await prefs.setString('password_warga', newPassCtrl.text);
                if (!mounted) return;
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Password berhasil diganti!')),
                );
              } else {
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Password lama salah!'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: const Text(
              'Perbarui',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  // 5. ISI PUSAT BANTUAN DESA (INFORMASI KONTAK PENTING KANTOR DESA)
  void _showHelpCenterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pusat Bantuan Desa',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Silakan hubungi kontak resmi perangkat desa jika mengalami kendala administrasi maupun teknis.',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(
                Icons.chat_bubble_outline,
                color: Colors.green,
              ),
              title: const Text('WhatsApp Layanan Desa'),
              subtitle: const Text('+62 822-1122-3344 (Jam Kerja)'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.email_outlined, color: Colors.blue),
              title: const Text('Email Resmi Desa'),
              subtitle: const Text('halo@gisting.desa.id'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(
                Icons.location_on_outlined,
                color: Colors.red,
              ),
              title: const Text('Kantor Balai Desa'),
              subtitle: const Text('Jl. Raya Gisting No. 01, Banjar Agung'),
              onTap: () {},
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // 6. ISI TENTANG APLIKASI BALAIKU (PENJELASAN PROYEK SMART VILLAGE)
  void _showAboutBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/Balaiku.png',
              height: 70,
              errorBuilder: (c, e, s) =>
                  const Icon(Icons.apps, size: 50, color: Color(0xFF0D6EFD)),
            ),
            const SizedBox(height: 15),
            const Text(
              'Tentang BalaiKu',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
            const Text(
              'Versi 1.0.0 (Beta Edition)',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            const SizedBox(height: 15),
            const Text(
              'BalaiKu adalah platform Smart Village digital terintegrasi yang dirancang untuk mempermudah pelayanan administrasi surat-menyurat warga, penyampaian aduan atau laporan fasilitas umum, pengembangan pasar UMKM lokal, serta penyediaan jalur darurat (SOS) bagi seluruh masyarakat desa.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF475569),
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // PROSES KELUAR AKUN AMAN
  Future<void> _prosesLogout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);

    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // HEADER BANNER & FOTO PROFIL OVERLAP
            Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 180,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF1E40AF), Color(0xFF0D6EFD)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                ),
                const Positioned(
                  top: 50,
                  child: Text(
                    'Profil Saya',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                Positioned(
                  top: 120,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 54,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: const Color(0x1A0D6EFD),
                            child: Text(
                              inisial,
                              style: const TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0D6EFD),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap:
                              _ubahFotoProfil, // Memanggil pilihan galeri/kamera
                          child: Container(
                            padding: const EdgeInsets.all(7),
                            decoration: BoxDecoration(
                              color: const Color(0xFF0D6EFD),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 2.5,
                              ),
                            ),
                            child: const Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 65),

            // NAMA & INFORMASI UTAMA WARGA
            Text(
              namaWarga,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              'NIK: $nikWarga',
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
              decoration: BoxDecoration(
                color: const Color(0x1A0D6EFD),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Warga Terdaftar - $alamatWarga',
                style: const TextStyle(
                  color: Color(0xFF0D6EFD),
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 30),

            // LIST MENU YANG SUDAH TERKONEKSI PENUH DENGAN FUNGSI DI ATAS
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 5, bottom: 12),
                    child: Text(
                      'Pengaturan & Informasi',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ),
                  _buildProfileMenu(
                    Icons.person_outline,
                    'Edit Informasi Data Diri',
                    _showEditProfileDialog,
                  ),
                  _buildProfileMenu(
                    Icons.lock_outline,
                    'Ganti Password',
                    _showSecurityDialog,
                  ),
                  _buildProfileMenu(
                    Icons.help_outline,
                    'Pusat Bantuan Desa',
                    _showHelpCenterBottomSheet,
                  ),
                  _buildProfileMenu(
                    Icons.info_outline,
                    'Tentang Aplikasi BalaiKu',
                    _showAboutBottomSheet,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),

            // TOMBOL KELUAR AKUN PREMIUM
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFEF2F2),
                  foregroundColor: const Color(0xFFDC2626),
                  minimumSize: const Size(double.infinity, 55),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: const BorderSide(color: Color(0xFFFCA5A5), width: 1),
                  ),
                ),
                onPressed: _prosesLogout,
                icon: const Icon(Icons.logout_rounded, size: 20),
                label: const Text(
                  'Keluar Akun',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileMenu(IconData icon, String title, VoidCallback onTap) {
    return Card(
      color: Colors.white,
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(color: Colors.grey.withValues(alpha: 0.15)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0x1A0D6EFD),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: const Color(0xFF0D6EFD), size: 22),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
            color: Color(0xFF1E293B),
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 14,
          color: Colors.grey,
        ),
        onTap: onTap,
      ),
    );
  }
}
