import 'package:app_tecno/sistema/globales.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MostrarProductos extends StatefulWidget {
  const MostrarProductos({super.key});

  @override
  State<MostrarProductos> createState() => _MostrarProductosState();
}

class _MostrarProductosState extends State<MostrarProductos> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  late Color _azul;
  late Color _naranja;
  late Color _celeste;

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

      if (product['categoria'] == catSeleccionada) {
        products.add(product);
      }
    }
    return products;
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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: _azul,
        title: Center(
          child: Text(
            catSeleccionada,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              label: const Text("Regresar",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  )),
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              style: ElevatedButton.styleFrom(backgroundColor: _naranja),
            ),
            const Divider(),
            FutureBuilder(
              future: getProducts(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.data.isEmpty) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.82,
                    child: Text(
                      "No hay productos en esta categoría",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: _celeste,
                        fontSize: 40,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  );
                } else {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.82,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          width: double.infinity,
                          child: Card(
                              color: _celeste,
                              shadowColor: _azul,
                              margin: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                        right: 15, top: 15),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          '\$',
                                          style: TextStyle(
                                              color: _naranja,
                                              fontSize: 30,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          snapshot.data[index]['precio']
                                              .toString(),
                                          style: TextStyle(
                                            color: _naranja,
                                            fontSize: 30,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                        top: 5, bottom: 5),
                                    child: Text(
                                      snapshot.data[index]['nombre'],
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.all(10),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Image.network(
                                        snapshot.data[index]['url'],
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.2),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        right: 15, left: 15),
                                    child: Text(
                                      snapshot.data[index]['descripcion'],
                                      textAlign: TextAlign.justify,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Center(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          total +=
                                              snapshot.data[index]['precio'];
                                          carrito.add({
                                            'nombre': snapshot.data[index]
                                                ['nombre'],
                                            'descripcion': snapshot.data[index]
                                                ['descripcion'],
                                            'url': snapshot.data[index]['url'],
                                            'precio': snapshot.data[index]
                                                ['precio'],
                                            'id': snapshot.data[index]['id'],
                                          });
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: _naranja,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        child: const Text("Añadir al carrito",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                            )),
                                      ),
                                    ),
                                  )
                                ],
                              )),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
