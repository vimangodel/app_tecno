import 'package:app_tecno/sistema/globales.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Carrito extends StatefulWidget {
  const Carrito({super.key});

  @override
  State<Carrito> createState() => _CarritoState();
}

class _CarritoState extends State<Carrito> {
  final Color _azul = const Color.fromARGB(255, 0, 60, 121);
  final Color _naranja = const Color.fromARGB(255, 255, 149, 0);
  final Color _celeste = const Color.fromARGB(255, 0, 176, 242);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Builder(builder: (context) {
          if (carrito.isEmpty) {
            return Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.783,
              child: Center(
                  child: Text("No hay productos en el carrito",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: _celeste,
                          fontSize: 40,
                          fontFamily: 'Gotham Medium',
                          fontWeight: FontWeight.w900))),
            );
          } else {
            return SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.783,
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: carrito.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Row(
                              children: [
                                Text("\$",
                                    style: TextStyle(
                                        color: _naranja,
                                        fontSize: 30,
                                        fontFamily: 'Gotham Medium',
                                        fontWeight: FontWeight.w900)),
                                Text(carrito[index]['precio'].toString(),
                                    style: TextStyle(
                                        color: _naranja,
                                        fontSize: 30,
                                        fontFamily: 'Gotham Medium',
                                        fontWeight: FontWeight.w900)),
                              ],
                            ),
                            subtitle: Text(carrito[index]['nombre'],
                                style: TextStyle(
                                    color: _azul,
                                    fontSize: 15,
                                    fontFamily: 'Gotham Medium',
                                    fontWeight: FontWeight.w600)),
                            trailing: IconButton(
                                icon: Icon(Icons.delete,
                                    color: _naranja, size: 40),
                                onPressed: () {
                                  setState(() {
                                    total = total - carrito[index]['precio'];
                                    carrito.removeAt(index);
                                  });
                                }),
                          );
                        }),
                  ),
                  const Divider(),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Total: ",
                            style: TextStyle(
                                color: _azul,
                                fontSize: 30,
                                fontFamily: 'Gotham Medium',
                                fontWeight: FontWeight.w900)),
                        Text("\$ $total",
                            style: TextStyle(
                                color: _naranja,
                                fontSize: 30,
                                fontFamily: 'Gotham Medium',
                                fontWeight: FontWeight.w900)),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(20),
                    width: double.infinity,
                    child: ElevatedButton.icon(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Compra realizada",
                                      style: TextStyle(
                                          color: _azul,
                                          fontSize: 20,
                                          fontFamily: 'Gotham Pro')),
                                  content: Text("Gracias por su compra",
                                      style: TextStyle(
                                          color: _azul,
                                          fontSize: 15,
                                          fontFamily: 'Gotham Pro')),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("Aceptar",
                                            style: TextStyle(
                                                color: _naranja,
                                                fontSize: 15,
                                                fontFamily: 'Gotham Pro')))
                                  ],
                                );
                              });
                          setState(() {
                            carrito.clear();
                            total = 0;
                          });
                        },
                        label: const Text("Comprar",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: 'Gotham Pro')),
                        icon: const Icon(Icons.shopping_cart,
                            color: Colors.white, size: 30),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: _naranja)),
                  )
                ],
              ),
            );
          }
        })
      ],
    );
  }
}
