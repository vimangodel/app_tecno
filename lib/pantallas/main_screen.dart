import 'package:app_tecno/sistema/globales.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app_tecno/widgets/admin.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late FirebaseFirestore db;
  late Color _azul;
  late Color _naranja;
  static late Color _celeste;
  late int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    Text('Contactos'),
    Text('Carrito'),
    Text('Categorías'),
    rol == 1
        ? const Admin()
        : rol == 2
            ? Center(
                child: Text(
                    "USTED NO TIENE ACCESO A LAS OPCIONES DE ADMINISTRADOR",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: _celeste,
                        fontWeight: FontWeight.w900,
                        fontSize: 28,
                        fontFamily: 'Gotham Pro')))
            : const SizedBox(),
    Text('Información'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    _selectedIndex = 0;
    _azul = const Color.fromARGB(255, 0, 60, 121);
    _naranja = const Color.fromARGB(255, 255, 149, 0);
    _celeste = const Color.fromARGB(255, 0, 176, 242);
    db = FirebaseFirestore.instance;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Center(
            child: _selectedIndex == 0
                ? const Text('CONTACTOS',
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 28,
                        color: Colors.white,
                        fontFamily: 'Gotham Pro'))
                : _selectedIndex == 1
                    ? const Text('CARRITO',
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 28,
                            color: Colors.white,
                            fontFamily: 'Gotham Pro'))
                    : _selectedIndex == 2
                        ? const Text('CATEGORÍAS',
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 28,
                                color: Colors.white,
                                fontFamily: 'Gotham Pro'))
                        : _selectedIndex == 3
                            ? const Text('ADMINISTRADOR',
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 28,
                                    color: Colors.white,
                                    fontFamily: 'Gotham Pro'))
                            : _selectedIndex == 4
                                ? const Text('INFORMACIÓN',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 28,
                                        color: Colors.white,
                                        fontFamily: 'Gotham Pro'))
                                : null,
          ),
          backgroundColor: _azul,
        ),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.contacts),
              label: 'Contactos',
              backgroundColor: Color.fromARGB(255, 0, 60, 121),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Carrito',
              backgroundColor: Color.fromARGB(255, 0, 60, 121),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.store),
              label: 'Compras',
              backgroundColor: Color.fromARGB(255, 0, 60, 121),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Opciones',
              backgroundColor: Color.fromARGB(255, 0, 60, 121),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info),
              label: 'Información',
              backgroundColor: Color.fromARGB(255, 0, 60, 121),
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: _naranja,
          iconSize: 60,
          showSelectedLabels: false,
          unselectedItemColor: Colors.white,
          onTap: _onItemTapped,
        ));
  }
}
