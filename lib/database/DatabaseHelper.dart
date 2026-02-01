import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  // Obtener la base de datos (singleton)
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Inicializar la base de datos
  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'loopplayer.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  // Crear tablas
  FutureOr<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE loop(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        trackName TEXT,
        albumArtistName TEXT,
        albumName TEXT,
        fileName TEXT,
        filePath TEXT,
        albumArt TEXT,
        start INTEGER,
        end INTEGER,
        favorite INTEGER NOT NULL DEFAULT 0
      )
    ''');
  }

  // Insertar un registro
  Future<int> insertLoop(Map<String, dynamic> loop) async {
    final db = await database;
    return await db.insert('loop', loop);
  }

  Future<int> updateLoop(Map<String, dynamic> loop, int id) async {
    final db = await database;
    return await db.update(
        'loop',
        loop,
      where: "id = ?",
      whereArgs: [id]
    );
  }

  // Obtener un registro por ID
  Future<Map<String, dynamic>?> getLoopById(int id) async {
    final db = await database;
    final result = await db.query('loop', where: 'id = ?', whereArgs: [id]);
    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }

  Future<List<Map<String, dynamic>>> getLoopByFavorite(bool favorite) async {
    final db = await database;
    final result = await db.query('loop', where: 'favorite = ?', whereArgs: [favorite ? 1 : 0]);
    return result;
  }

  Future<List<Map<String, dynamic>>> getLoops() async {
    final db = await database;
    final result = await db.query('loop');
    return result;
  }

  Future<void> deleteById(int id) async {
    final db = await database;
    await db.delete('loop', where: "id = ?", whereArgs: [id]);
  }
}