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
    await _databaseHelper.updateEconomy(monthlyEconomy, totalEconomy);
  }

  Future<void> addEconomyValues() async {
    await addEconomyData(130.0, 200.0);
    print('Valores de economia adicionados com sucesso!');
  }


}
