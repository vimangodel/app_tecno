import 'dart:io';
import 'package:app_tecno/pantallas/main_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddProductos extends StatefulWidget {
  const AddProductos({super.key});

  @override
  State<AddProductos> createState() => _AddProductosState();
}

class _AddProductosState extends State<AddProductos> {
  GlobalKey<FormState> formularioEstado = GlobalKey<FormState>();
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  File? _imagen;
  late String _url;
  bool subida = false;
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
  late List listaProductos;
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

  Future<void> subirImagen() async {
    final product = _productoController.text;
    final ref = storage.ref().child("productos/$product.png");
    await ref.putFile(_imagen!);
    final downloadUrl = await ref.getDownloadURL();
    setState(() {
      _url = downloadUrl;
      subida = true;
    });
  }

  Future<void> agregarProducto() async {
    String url = _url;
    String producto = _productoController.text;
    double precio = double.parse(_precioController.text);
    String descripcion = _descripcionController.text;
    int stock = int.parse(_stockController.text);
    String categoria = _categoriaSeleccionada;
    DateTime fecha = DateTime.now();
    if (formularioEstado.currentState!.validate() && _imagen != null) {
      await db.collection('productos').add({
        'nombre': producto,
        'precio': precio,
        'descripcion': descripcion,
        'stock': stock,
        'categoria': categoria,
        'url': url,
        'fecha': fecha,
      });
    }
  }

  Future<void> getProductos() async {
    List productos = [];
    CollectionReference collectionReferenceProductos =
        db.collection('productos');

    QuerySnapshot queryProductos = await collectionReferenceProductos.get();

    for (var documento in queryProductos.docs) {
      productos.add(documento['nombre']);
    }
    setState(() {
      listaProductos = productos;
    });
  }

  @override
  void initState() {
    _categoriaSeleccionada = _categorias[5];
    _azul = const Color.fromARGB(255, 0, 60, 121);
    _naranja = const Color.fromARGB(255, 255, 149, 0);
    listaProductos = [];
    _url = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getProductos();

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
                        _imagen == null
                            ? const Text('No hay imagen')
                            : Image.file(_imagen!),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton.icon(
                                onPressed: () {
                                  _getImage();
                                },
                                icon: const Icon(Icons.add_photo_alternate),
                                label: const Text('Seleccionar')),
                            ElevatedButton.icon(
                                onPressed: () {
                                  if (_imagen != null &&
                                      _productoController.text.isNotEmpty) {
                                    subirImagen();
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Por favor, seleccione una imagen y añada el nombre del producto')));
                                  }
                                },
                                icon: const Icon(Icons.upload),
                                label: const Text('Subir')),
                          ],
                        ),
                        const Divider(),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child: TextFormField(
                          controller: _productoController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor, ingrese un producto';
                            }
                            if (listaProductos.contains(value)) {
                              return 'El producto ya existe en la base de datos';
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
                              if (formularioEstado.currentState!.validate() &&
                                  _imagen != null &&
                                  subida) {
                                agregarProducto();
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Producto agregado correctamente')));
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            const MainScreen()));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Presione el botón de subir imagen antes de añadir el producto')));
                              }
                            },
                            label: const Text("Añadir",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontFamily: "Gotham Medium",
                                    fontWeight: FontWeight.w600)),
                            icon: const Icon(Icons.add, color: Colors.white),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: _azul)),
                      ],
                    )
                  ],
                )),
          ],
        ));
  }
}
