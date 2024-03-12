import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'database_helper.dart'; // Importe o DatabaseHelper
import 'main.dart';

class EconomiaPage extends StatefulWidget {
  const EconomiaPage({Key? key}) : super(key: key);

  @override
  State<EconomiaPage> createState() => _EconomiaPageWidgetState();
}

class _EconomiaPageWidgetState extends State<EconomiaPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late double _monthlyEconomy = 0.0;
  late double _totalEconomy = 0.0;
  late final DatabaseHelper _databaseHelper;

  @override
  void initState() {
    super.initState();
    _databaseHelper = DatabaseHelper(); // Inicialize a instância de DatabaseHelper
    _fetchEconomyValues();
  }

  Future<void> _fetchEconomyValues() async {
    final monthlyEconomy = await _databaseHelper.getMonthlyEconomy();
    final totalEconomy = await _databaseHelper.getTotalEconomy();

    setState(() {
      _monthlyEconomy = monthlyEconomy;
      _totalEconomy = totalEconomy;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xFF0E151B),
        leading: IconButton(
          icon: Icon(Icons.menu),
          color: Color(0xFF45BF85),
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
        ),
      ),
      backgroundColor: Color(0xFF45BF85),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.08,
            decoration: BoxDecoration(
              color: Color(0xFF0E151B),
              border: Border.all(
                color: Color(0xFF0E151B),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Align(
                  alignment: AlignmentDirectional(-1, 1),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 30),
                    child: Text(
                      'USER',
                      style: TextStyle(
                        fontFamily: 'Readex Pro',
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Align(
                    alignment: AlignmentDirectional(1, 1),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 20, 20),
                      child: Container(
                        width: 150,
                        height: 43,
                        decoration: BoxDecoration(
                          color: Color(0x58FFFFFF),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Align(
                              alignment: AlignmentDirectional(-1, 0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 0, 0, 0),
                                child: Icon(
                                  Icons.eco_outlined,
                                  color: Colors.green,
                                  size: 24,
                                ),
                              ),
                            ),
                            Flexible(
                              child: Align(
                                alignment: AlignmentDirectional(1, 0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 10, 0),
                                  child: Text(
                                    '0',
                                    style: TextStyle(
                                      fontFamily: 'Readex Pro',
                                      color: Colors.white,
                                      fontSize: 24,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Align(
              alignment: AlignmentDirectional(0, -1),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.65,
                decoration: BoxDecoration(
                  color: Color(0xFF45BF85),
                ),
                child: Align(
                  alignment: AlignmentDirectional(0, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Align(
                                alignment: AlignmentDirectional(1, 0),
                                child: Icon(
                                  Icons.calendar_month,
                                  color: Color(0xFF0E151B),
                                  size: 60,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: AlignmentDirectional(-1, 0),
                                child: Icon(
                                  Icons.energy_savings_leaf_rounded,
                                  color: Color(0xFF0E151B),
                                  size: 60,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'Economia no mês: $_monthlyEconomy KW', // Use o valor do banco de dados aqui
                        style: TextStyle(
                          fontFamily: 'Readex Pro',
                          fontSize: 32,
                          color: Colors.white,
                        ),
                      ),
                      FaIcon(
                        FontAwesomeIcons.equals,
                        color: Color(0xFF0E151B),
                        size: 35,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Align(
                              alignment: AlignmentDirectional(1, 0),
                              child: Icon(
                                Icons.eco_outlined,
                                color: Colors.green,
                                size: 38,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: AlignmentDirectional(-1, 0),
                              child: Text(
                                '0',
                                style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 32,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Align(
                                alignment: AlignmentDirectional(1, 0),
                                child: Icon(
                                  Icons.electric_bolt,
                                  color: Color(0xFF0E151B),
                                  size: 40,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: AlignmentDirectional(-1, 0),
                                child: Icon(
                                  Icons.energy_savings_leaf_outlined,
                                  color: Color(0xFF0E151B),
                                  size: 40,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'Economia total: $_totalEconomy KW', // Use o valor do banco de dados aqui
                        style: TextStyle(
                          fontFamily: 'Readex Pro',
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional(0, 0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.15,
              decoration: BoxDecoration(
                color: Color(0xFF0E151B),
              ),
              alignment: AlignmentDirectional(0, 0),
              child: Padding(
                padding: EdgeInsets.only(
                    top: 8.0), // Espaçamento de 8.0 pixels acima do Row
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Flexible(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => EconomiaPage()),
                          );
                        },
                        child: Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Align(
                                alignment: AlignmentDirectional(0, 1),
                                child: Icon(
                                  Icons.electric_bolt,
                                  color: Color(0xFF45BF85),
                                  size: 60,
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(0, -1),
                                child: Text(
                                  'Economia',
                                  style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    color: Color(0xFF8A8A8A),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MyApp()),
                          );
                        },
                        child: Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Align(
                                alignment: AlignmentDirectional(0, 1),
                                child: Icon(
                                  Icons.person,
                                  color: Color(0xFF45BF85),
                                  size: 40,
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(0, -1),
                                child: Text(
                                  'Avatar',
                                  style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    color: Color(0xFF8A8A8A),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => EconomiaPage()),
                          );
                        },
                        child: Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Align(
                                alignment: AlignmentDirectional(0, 1),
                                child: Icon(
                                  Icons.shopping_cart,
                                  color: Color(0xFF45BF85),
                                  size: 40,
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(0, -1),
                                child: Text(
                                  'Loja',
                                  style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    color: Color(0xFF8A8A8A),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF0E151B),
              ),
              child: Text(
                'Eco Game',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Modificar aparência'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewPage()),
                );
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
