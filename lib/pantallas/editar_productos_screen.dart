import 'package:app_tecno/sistema/globales.dart';
import 'package:app_tecno/widgets/add_productos.dart';
import 'package:app_tecno/widgets/editar_productos.dart';
import 'package:flutter/material.dart';

class EditarProductosScreen extends StatefulWidget {
  const EditarProductosScreen({super.key});

  @override
  State<EditarProductosScreen> createState() => _EditarProductosScreenState();
}

class _EditarProductosScreenState extends State<EditarProductosScreen> {
  final Color _azul = const Color.fromARGB(255, 0, 60, 121);
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: _azul,
        automaticallyImplyLeading: false,
        title: Center(
          child: productIndex == 2
              ? const Text(
                  'Editar producto',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    //backgroundColor: const Color.fromARGB(255, 0, 60, 121),
                  ),
                )
              : const Text(
                  'Añadir producto nuevo',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    //backgroundColor: const Color.fromARGB(255, 0, 60, 121),
                  ),
                ),
        ),
      ),
      body: productIndex == 2 ? const EditarProductos() : const AddProductos(),
    ));
  }
}
