import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'economia_page.dart';

class DatabaseHelper {
  static const String tableName = 'economy';
  static const String columnId = 'id';
  static const String columnMonthlyEconomy = 'monthly_economy';
  static const String columnTotalEconomy = 'total_economy';

  late Database _database;

  Future<Database> open() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'economy_database.db'),
      onCreate: (db, version) {
        return db.execute(
          '''
          CREATE TABLE $tableName (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnMonthlyEconomy REAL,
            $columnTotalEconomy REAL
          )
          ''',
        );
      },
      version: 1,
    );
    return _database;
  }

  Future<void> insertEconomy(double monthlyEconomy, double totalEconomy) async {
    await open();
    await _database.insert(
      tableName,
      {
        columnMonthlyEconomy: monthlyEconomy,
        columnTotalEconomy: totalEconomy,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateEconomy(double monthlyEconomy, double totalEconomy) async {
    await open();
    await _database.update(
      tableName,
      {
        columnMonthlyEconomy: monthlyEconomy,
        columnTotalEconomy: totalEconomy,
      },
    );
  }

  Future<List<Map<String, dynamic>>> getEconomies() async {
    await open();
    return await _database.query(tableName);
  }

  Future<double> getMonthlyEconomy() async {
    await open();
    final List<Map<String, dynamic>> results = await _database.query(tableName);
    if (results.isNotEmpty) {
      return results.first[columnMonthlyEconomy] as double;
    } else {
      return 0.0;
    }
  }

  Future<double> getTotalEconomy() async {
    await open();
    final List<Map<String, dynamic>> results = await _database.query(tableName);
    if (results.isNotEmpty) {
      return results.first[columnTotalEconomy] as double;
    } else {
      return 0.0;
    }
  }
}
