import 'dart:io';
import 'package:app_tecno/pantallas/main_screen.dart';
import 'package:app_tecno/sistema/globales.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditarProductos extends StatefulWidget {
  const EditarProductos({super.key});

  @override
  State<EditarProductos> createState() => _EditarProductosState();
}

class _EditarProductosState extends State<EditarProductos> {
  GlobalKey<FormState> formularioEstado = GlobalKey<FormState>();
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  File? _imagen;
  String _url = '';
  List listaProductos = [];
  final TextEditingController _productoController = TextEditingController();
  final TextEditingController _precioController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();
  final List<String> _categorias = [
    'Cocina',
    'Limpieza',
    'Cuidado Personal',
    'Climatización',
    'Jardín',
    'Otros',
  ];
  late String _categoriaSeleccionada;
  late Color _azul;
  late Color _naranja;

  Future _getImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imagen = File(pickedFile.path);
      });
    }
  }

  Future<void> getImagen() async {
    final product = _productoController.text;
    final ref = storage.ref().child("productos/$product.png");
    await ref.putFile(_imagen!);
    final downloadUrl = await ref.getDownloadURL();
    setState(() {
      _url = downloadUrl;
    });
  }

  Future<void> getProductos() async {
    List productos = [];
    CollectionReference collectionReferenceProductos =
        db.collection('productos');

    QuerySnapshot queryProductos = await collectionReferenceProductos.get();

    for (var documento in queryProductos.docs) {
      if (documento['nombre'] != editProducto) {
        productos.add(documento['nombre']);
      }
    }
    setState(() {
      listaProductos = productos;
    });
  }

  @override
  void initState() {
    _categoriaSeleccionada = editCategoria;
    _azul = const Color.fromARGB(255, 0, 60, 121);
    _naranja = const Color.fromARGB(255, 255, 149, 0);
    _url = editUrl;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _productoController.text = editProducto;
    _precioController.text = editPrecio.toString();
    _descripcionController.text = editDescripcion;
    _stockController.text = editStock.toString();

    return Container(
        margin: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Form(
                key: formularioEstado,
                child: Column(
                  children: [
                    Column(
                      children: [
                        _url == ''
                            ? const CircularProgressIndicator()
                            : Image.network(_url),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton.icon(
                                onPressed: () {
                                  _getImage();
                                  getImagen();
                                },
                                icon: const Icon(Icons.image),
                                label: const Text('Actualizar')),
                          ],
                        ),
                      ],
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child: TextFormField(
                          controller: _productoController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, ingrese un producto';
                            }
                            if (listaProductos.contains(value)) {
                              return 'El producto ya existe';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              labelText: 'Producto',
                              hintText: 'Producto',
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              )),
                        )),
                    Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child: TextFormField(
                          controller: _precioController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor, ingrese un precio';
                            }
                            if (double.tryParse(value) == null) {
                              return 'Por favor, ingrese un número separado por punto';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              labelText: 'Precio',
                              hintText: 'Precio',
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              )),
                        )),
                    Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child: TextFormField(
                          controller: _descripcionController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor, ingrese una descripción';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              labelText: 'Descripción',
                              hintText: 'Descripción',
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              )),
                        )),
                    Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child: TextFormField(
                          controller: _stockController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor, ingrese el stock';
                            }
                            if (int.tryParse(value) == null) {
                              return 'Por favor, ingrese un número entero';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              labelText: 'Stock',
                              hintText: 'Stock',
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              )),
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Categoría:  ',
                            style: TextStyle(
                                color: _azul,
                                fontSize: 20,
                                fontFamily: "Gotham Medium",
                                fontWeight: FontWeight.w600)),
                        DropdownButton<String>(
                            value: _categoriaSeleccionada,
                            items: _categorias
                                .map<DropdownMenuItem<String>>((String item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Text(item,
                                    style: TextStyle(
                                        color: _azul,
                                        fontSize: 17,
                                        fontFamily: "Gotham Medium",
                                        fontWeight: FontWeight.w500)),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              setState(() {
                                if (value != null) {
                                  _categoriaSeleccionada = value;
                                }
                              });
                            }),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            label: const Text("Regresar",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontFamily: "Gotham Medium",
                                    fontWeight: FontWeight.w600)),
                            icon: const Icon(Icons.arrow_back,
                                color: Colors.white),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: _azul)),
                        ElevatedButton.icon(
                            onPressed: () {
                              if (formularioEstado.currentState!.validate()) {
                                actualizarProducto(editIdProducto);
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Producto actualizado correctamente')));
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            const MainScreen()));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Por favor, complete los campos')));
                              }
                            },
                            label: const Text("Actualizar",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontFamily: "Gotham Medium",
                                    fontWeight: FontWeight.w600)),
                            icon: const Icon(Icons.update, color: Colors.white),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: _azul)),
                      ],
                    )
                  ],
                )),
          ],
        ));
  }

  Future<void> actualizarProducto(id) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference productos = db.collection('productos');
    String url = _url;
    String producto = _productoController.text;
    double precio = double.parse(_precioController.text);
    String descripcion = _descripcionController.text;
    int stock = int.parse(_stockController.text);
    String categoria = _categoriaSeleccionada;

    await productos.doc(id).update({
      'nombre': producto,
      'precio': precio,
      'descripcion': descripcion,
      'stock': stock,
      'categoria': categoria,
      'url': url,
    });
  }
}
