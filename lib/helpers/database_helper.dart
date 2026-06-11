import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('balaiku.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    // Tabel untuk Pelayanan Surat
    await db.execute('''
      CREATE TABLE surat (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        jenis_surat TEXT NOT NULL,
        keperluan TEXT NOT NULL,
        tanggal TEXT NOT NULL,
        status TEXT NOT NULL
      )
    ''');

    // Tabel untuk Form Laporan Warga
    await db.execute('''
      CREATE TABLE laporan (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        jenis_laporan TEXT NOT NULL,
        deskripsi TEXT NOT NULL,
        tanggal TEXT NOT NULL,
        status TEXT NOT NULL
      )
    ''');

    // Tabel untuk Pasar Warga (UMKM)
    await db.execute('''
      CREATE TABLE umkm (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nama_usaha TEXT NOT NULL,
        penjual TEXT NOT NULL,
        alamat TEXT NOT NULL,
        harga TEXT NOT NULL,
        gambar TEXT NOT NULL
      )
    ''');
  }

  // --- FUNGSI UNTUK PASAR WARGA ---
  Future<int> insertUMKM(Map<String, dynamic> data) async {
    final db = await instance.database;
    return await db.insert('umkm', data);
  }

  Future<List<Map<String, dynamic>>> getAllUMKM() async {
    final db = await instance.database;
    return await db.query('umkm', orderBy: 'id DESC');
  }

  // --- FUNGSI UNTUK SURAT & LAPORAN ---
  Future<int> insertSurat(Map<String, dynamic> data) async {
    final db = await instance.database;
    return await db.insert('surat', data);
  }

  Future<int> insertLaporan(Map<String, dynamic> data) async {
    final db = await instance.database;
    return await db.insert('laporan', data);
  }

  Future<List<Map<String, dynamic>>> getAllSurat() async {
    final db = await instance.database;
    return await db.query('surat', orderBy: 'id DESC');
  }

  Future<List<Map<String, dynamic>>> getAllLaporan() async {
    final db = await instance.database;
    return await db.query('laporan', orderBy: 'id DESC');
  }

  // INI ADALAH FUNGSI BARU UNTUK MENGHAPUS DATA

  Future<int> deleteSurat(int id) async {
    final db = await instance.database;
    return await db.delete('surat', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteLaporan(int id) async {
    final db = await instance.database;
    return await db.delete('laporan', where: 'id = ?', whereArgs: [id]);
  }
}
