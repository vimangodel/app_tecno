import 'package:app_tecno/pantallas/editar_productos_screen.dart';
import 'package:app_tecno/pantallas/productos_screen.dart';
import 'package:app_tecno/sistema/globales.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FormProductos extends StatefulWidget {
  const FormProductos({super.key});

  @override
  State<FormProductos> createState() => _FormProductosState();
}

class _FormProductosState extends State<FormProductos> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  late final GlobalKey<FormState> _formularioEstado;
  final List<String> _categorias = [
    'Cocina',
    'Limpieza',
    'Cuidado Personal',
    'Climatización',
    'Jardín',
    'Otros',
  ];
  late String? _categoriaSeleccionada;
  late Color _azul;
  late Color _naranja;

  Future<List> getProducts() async {
    List products = [];
    CollectionReference collectionReferenceProducts =
        db.collection('productos');

    QuerySnapshot queryProductos = await collectionReferenceProducts.get();

    for (var documento in queryProductos.docs) {
      final Map<String, dynamic> data =
          documento.data() as Map<String, dynamic>;
      final product = {
        'nombre': data['nombre'],
        'descripcion': data['descripcion'],
        'precio': data['precio'],
        'stock': data['stock'],
        'categoria': data['categoria'],
        'url': data['url'],
        'id': documento.id,
      };

      if (product['categoria'] == _categoriaSeleccionada) {
        products.add(product);
      }
    }
    return products;
  }

  @override
  void initState() {
    _formularioEstado = GlobalKey<FormState>();
    _categoriaSeleccionada = null;
    _azul = const Color.fromARGB(255, 0, 60, 121);
    _naranja = const Color.fromARGB(255, 255, 149, 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton.icon(
            onPressed: () {
              editProducto = "";
              editDescripcion = "";
              editPrecio = 0;
              editStock = 0;
              editCategoria = "";
              editUrl = "";
              editIdProducto = "";
              productIndex = 1;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const EditarProductosScreen()));
            },
            label: const Text("Añadir producto",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: "Gotham Medium",
                    fontWeight: FontWeight.w600)),
            icon: const Icon(Icons.add, color: Colors.white),
            style: ElevatedButton.styleFrom(backgroundColor: _azul)),
        const Padding(padding: EdgeInsets.only(top: 20)),
        Text("Búsqueda por categorías",
            style: TextStyle(
                color: _azul,
                fontSize: 20,
                fontFamily: "Gotham Medium",
                fontWeight: FontWeight.w600)),
        Form(
            key: _formularioEstado,
            child: Row(
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
            )),
        const Divider(),
        FutureBuilder(
            future: getProducts(),
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  constraints: BoxConstraints.tightForFinite(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.359,
                  ),
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(snapshot.data?[index]['categoria']),
                          subtitle: Text(snapshot.data?[index]['nombre']),
                          onTap: () {
                            productIndex = 2;
                            editProducto = snapshot.data?[index]['nombre'];
                            editDescripcion =
                                snapshot.data?[index]['descripcion'];
                            editPrecio = snapshot.data?[index]['precio'];
                            editStock = snapshot.data?[index]['stock'];
                            editCategoria = snapshot.data?[index]['categoria'];
                            editUrl = snapshot.data?[index]['url'];
                            editIdProducto = snapshot.data?[index]['id'];
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const MostrarProductosScreen()));

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Datos encontrados'),
                              ),
                            );
                          },
                        );
                      }),
                );
              }

              return const SizedBox(
                height: 20,
              );
            }))
      ],
    );
  }
}
