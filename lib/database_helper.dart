import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'economia_page.dart';

class DatabaseHelper {
  static const String tableName = 'economy';
  static const String columnId = 'id';
  static const String columnMonthlyEconomy = 'monthly_economy';
  static const String columnTotalEconomy = 'total_economy';
  static const String columnCoins = 'coins'; // Nova coluna para as moedas

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
            $columnTotalEconomy REAL,
            $columnCoins REAL // Adiciona a coluna de moedas
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
    // Calcula o valor das moedas (20% da economia total)
    final coins = totalEconomy * 0.2;
    await _database.insert(
      tableName,
      {
        columnMonthlyEconomy: monthlyEconomy,
        columnTotalEconomy: totalEconomy,
        columnCoins: coins, // Insere o valor das moedas no banco de dados
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
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

  Future<double> getCoins() async {
    await open();
    final List<Map<String, dynamic>> results = await _database.query(tableName);
    if (results.isNotEmpty && results.first.containsKey(columnCoins)) {
      return results.first[columnCoins] as double;
    } else {
      return 0.0; // Ou outro valor padrão que faça sentido para sua aplicação
    }
  }
}
