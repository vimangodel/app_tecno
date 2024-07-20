import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MainWidget extends StatefulWidget {
  const MainWidget({super.key});

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  Color _azul = Color.fromARGB(255, 0, 60, 121);
  Color _naranja = Color.fromARGB(255, 255, 149, 0);
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Text('Index 0: Contactos'),
    Text('Index 1: Carrito'),
    Text('Index 2: Compras'),
    Text('Index 3: Opciones'),
    Text('Index 4: Información'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
