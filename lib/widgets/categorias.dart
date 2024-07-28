import 'package:app_tecno/sistema/globales.dart';
import 'package:app_tecno/widgets/mostrar_productos.dart';
import 'package:flutter/material.dart';

class Categorias extends StatefulWidget {
  const Categorias({super.key});

  @override
  State<Categorias> createState() => _CategoriasState();
}

class _CategoriasState extends State<Categorias> {
  final Color _celeste = const Color.fromARGB(255, 0, 176, 242);
  final List<String> _categorias = [
    'Cocina',
    'Limpieza',
    'Cuidado Personal',
    'Climatización',
    'Jardín',
    'Otros',
  ];
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10),
                width: MediaQuery.of(context).size.width * 0.45,
                height: MediaQuery.of(context).size.height * 0.24,
                decoration: BoxDecoration(
                  color: _celeste,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "COCINA",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Gotham Medium',
                        fontWeight: FontWeight.w700,
                        fontSize: 25,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        catSeleccionada = _categorias[0];
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const MostrarProductos()));
                      },
                      icon: const Icon(Icons.kitchen_rounded,
                          color: Colors.white),
                      iconSize: 125,
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                width: MediaQuery.of(context).size.width * 0.45,
                height: MediaQuery.of(context).size.height * 0.24,
                decoration: BoxDecoration(
                  color: _celeste,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "LIMPIEZA",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Gotham Medium',
                        fontWeight: FontWeight.w700,
                        fontSize: 25,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        catSeleccionada = _categorias[1];
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const MostrarProductos()));
                      },
                      icon: const Icon(Icons.local_laundry_service,
                          color: Colors.white),
                      iconSize: 125,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10),
                width: MediaQuery.of(context).size.width * 0.45,
                height: MediaQuery.of(context).size.height * 0.24,
                decoration: BoxDecoration(
                  color: _celeste,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "CUIDADO PERSONAL",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Gotham Medium',
                        fontWeight: FontWeight.w700,
                        fontSize: 23,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        catSeleccionada = _categorias[2];
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const MostrarProductos()));
                      },
                      icon: const Icon(Icons.self_improvement,
                          color: Colors.white),
                      iconSize: 110,
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                width: MediaQuery.of(context).size.width * 0.45,
                height: MediaQuery.of(context).size.height * 0.24,
                decoration: BoxDecoration(
                  color: _celeste,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "CLIMATIZACIÓN",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Gotham Medium',
                        fontWeight: FontWeight.w700,
                        fontSize: 21,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        catSeleccionada = _categorias[3];
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const MostrarProductos()));
                      },
                      icon:
                          const Icon(Icons.sunny_snowing, color: Colors.white),
                      iconSize: 125,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10),
                width: MediaQuery.of(context).size.width * 0.45,
                height: MediaQuery.of(context).size.height * 0.25,
                decoration: BoxDecoration(
                  color: _celeste,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "JARDÍN",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Gotham Medium',
                        fontWeight: FontWeight.w700,
                        fontSize: 23,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        catSeleccionada = _categorias[4];
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const MostrarProductos()));
                      },
                      icon: const Icon(Icons.eco, color: Colors.white),
                      iconSize: 119,
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                width: MediaQuery.of(context).size.width * 0.45,
                height: MediaQuery.of(context).size.height * 0.25,
                decoration: BoxDecoration(
                  color: _celeste,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "OTROS",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Gotham Medium',
                        fontWeight: FontWeight.w700,
                        fontSize: 25,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        catSeleccionada = _categorias[5];
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const MostrarProductos()));
                      },
                      icon: const Icon(Icons.computer, color: Colors.white),
                      iconSize: 125,
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
