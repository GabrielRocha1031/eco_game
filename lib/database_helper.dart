import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  static Database? _db;

  DatabaseHelper.internal();

  Future<Database?> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  Future<Database> initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'my_database.db');

    // Abra o banco de dados (ou crie-o se não existir)
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  void _onCreate(Database db, int version) async {
    // Crie a estrutura da tabela aqui
    await db.execute('''
      CREATE TABLE my_table (
        id INTEGER PRIMARY KEY,
        name TEXT,
        age INTEGER
      )
    ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database dbClient = await db;
    return await dbClient.insert('my_table', row);
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    Database dbClient = await db;
    return await dbClient.query('my_table');
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database dbClient = await db;
    return await dbClient.update('my_table', row, where: 'id = ?', whereArgs: [row['id']]);
  }

  Future<int> delete(int id) async {
    Database dbClient = await db;
    return await dbClient.delete('my_table', where: 'id = ?', whereArgs: [id]);
  }
}
