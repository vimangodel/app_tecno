import 'package:app_tecno/pantallas/editar_productos_screen.dart';
import 'package:app_tecno/pantallas/main_screen.dart';
import 'package:app_tecno/sistema/globales.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class Productos extends StatefulWidget {
  const Productos({super.key});

  @override
  State<Productos> createState() => _ProductosState();
}

class _ProductosState extends State<Productos> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  late Color _naranja;
  late Color _azul;
  late Color _celeste;

  Future<void> eliminarProducto(id) async {
    CollectionReference productos = db.collection('productos');

    QuerySnapshot queryProductos = await productos.get();

    for (var documento in queryProductos.docs) {
      productos.doc(id).delete();
    }
  }

  @override
  void initState() {
    _azul = const Color.fromARGB(255, 0, 60, 121);
    _naranja = const Color.fromARGB(255, 255, 149, 0);
    _celeste = const Color.fromARGB(255, 0, 176, 242);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              Column(
                children: [
                  editUrl != ""
                      ? Image.network(editUrl,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.25)
                      : const CircularProgressIndicator(),
                  ListTile(
                    title: Text("Producto",
                        style: TextStyle(
                            color: _azul,
                            fontSize: 20,
                            fontFamily: 'Gotham Pro')),
                    subtitle: Text(editProducto,
                        style: TextStyle(
                            color: _azul,
                            fontSize: 15,
                            fontFamily: 'Gotham Medium',
                            fontWeight: FontWeight.w500)),
                  ),
                  ListTile(
                    title: Text("Precio",
                        style: TextStyle(
                            color: _azul,
                            fontSize: 20,
                            fontFamily: 'Gotham Pro')),
                    subtitle: Text("\$ $editPrecio",
                        style: TextStyle(
                            color: _azul,
                            fontSize: 15,
                            fontFamily: 'Gotham Medium',
                            fontWeight: FontWeight.w500)),
                  ),
                  ListTile(
                    title: Text("Descripción",
                        style: TextStyle(
                            color: _azul,
                            fontSize: 20,
                            fontFamily: 'Gotham Pro')),
                    subtitle: Text(editDescripcion,
                        style: TextStyle(
                            color: _azul,
                            fontFamily: 'Gotham Medium',
                            fontWeight: FontWeight.w500)),
                  ),
                  ListTile(
                    title: Text("Categoría",
                        style: TextStyle(
                            color: _azul,
                            fontSize: 20,
                            fontFamily: 'Gotham Pro')),
                    subtitle: Text(editCategoria,
                        style: TextStyle(
                            color: _azul,
                            fontSize: 15,
                            fontFamily: 'Gotham Medium',
                            fontWeight: FontWeight.w500)),
                  ),
                  ListTile(
                    title: Text("Stock",
                        style: TextStyle(
                            color: _azul,
                            fontSize: 20,
                            fontFamily: 'Gotham Pro')),
                    subtitle: Text("$editStock",
                        style: TextStyle(
                            color: _azul,
                            fontSize: 15,
                            fontFamily: 'Gotham Medium',
                            fontWeight: FontWeight.w500)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const EditarProductosScreen()));
                          },
                          label: const Text("Editar",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: 'Gotham Medium')),
                          icon: const Icon(Icons.edit, color: Colors.white),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _naranja,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          )),
                      ElevatedButton.icon(
                        onPressed: () {
                          eliminarProducto(editIdProducto);
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Producto eliminado")));
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const MainScreen()));
                        },
                        label: const Text("Eliminar",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: 'Gotham Medium')),
                        icon: const Icon(Icons.delete, color: Colors.white),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _naranja,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      label: const Text("Regresar",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'Gotham Medium')),
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _naranja,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          )),
    );
  }
}
