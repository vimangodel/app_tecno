import 'package:flutter/material.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  late final GlobalKey<FormState> _formularioEstado;
  late Color _naranja;

  @override
  void initState() {
    _formularioEstado = GlobalKey<FormState>();
    _naranja = const Color.fromARGB(255, 255, 149, 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      const SizedBox(
        height: 20,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: _naranja,
            ),
            onPressed: () {},
            label: const Text("Clientes",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Gotham Pro')),
            icon: const Icon(Icons.groups, color: Colors.white, size: 30),
            iconAlignment: IconAlignment.start,
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: _naranja,
            ),
            onPressed: () {},
            label: const Text("Productos",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Gotham Pro')),
            icon: const Icon(Icons.inventory, color: Colors.white, size: 30),
            iconAlignment: IconAlignment.start,
          ),
        ],
      ),
      Form(
          key: _formularioEstado,
          child: Column(
            children: [Row(children: [])],
          ))
    ]);
  }
}
