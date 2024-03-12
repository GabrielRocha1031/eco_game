import 'package:flutter/material.dart';
import 'database_helper.dart';

class DataManager {
  late final DatabaseHelper _databaseHelper;

  DataManager() {
    _databaseHelper = DatabaseHelper();
    _init();
  }

  Future<void> _init() async {
    await _databaseHelper.open();
  }

  Future<void> addEconomyData(double monthlyEconomy, double totalEconomy) async {
    await _databaseHelper.insertEconomy(monthlyEconomy, totalEconomy);
  }

  Future<void> addEconomyValues() async {
    await addEconomyData(15.0, 280.0);
    print('Valores de economia adicionados com sucesso!');
  }


}
