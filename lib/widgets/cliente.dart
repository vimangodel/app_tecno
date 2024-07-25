import 'package:app_tecno/pantallas/editar_cliente_screen.dart';
import 'package:flutter/material.dart';
import 'package:app_tecno/sistema/globales.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Cliente extends StatefulWidget {
  const Cliente({super.key});

  @override
  State<Cliente> createState() => _ClienteState();
}

class _ClienteState extends State<Cliente> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  late Color _naranja;
  late Color _azul;

  Future<void> eliminarUsuario(id) async {
    CollectionReference usuarios = db.collection('usuarios');

    QuerySnapshot queryUsuarios = await usuarios.get();

    queryUsuarios.docs.forEach((documento) {
      usuarios.doc(id).delete();
    });
  }

  @override
  void initState() {
    _azul = const Color.fromARGB(255, 0, 60, 121);
    _naranja = const Color.fromARGB(255, 255, 149, 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            color: Colors.white,
            child: ListView(
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.person, size: 150, color: _azul),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Nombre: $editNombre",
                                style: TextStyle(
                                    color: _azul,
                                    fontSize: 13,
                                    fontFamily: 'Gotham Pro')),
                            Text("Apellido: $editApellidos",
                                style: TextStyle(
                                    color: _azul,
                                    fontSize: 13,
                                    fontFamily: 'Gotham Pro')),
                            Text("Usuario: $editUsuario",
                                style: TextStyle(
                                    color: _azul,
                                    fontSize: 13,
                                    fontFamily: 'Gotham Pro')),
                            Text("Correo: $editEmail",
                                style: TextStyle(
                                    color: _azul,
                                    fontSize: 13,
                                    fontFamily: 'Gotham Pro')),
                            Text("Telefono: $editTelefono",
                                style: TextStyle(
                                    color: _azul,
                                    fontSize: 13,
                                    fontFamily: 'Gotham Pro')),
                            Text("Dirección: $editDireccion",
                                style: TextStyle(
                                    color: _azul,
                                    fontSize: 13,
                                    fontFamily: 'Gotham Pro')),
                            Text("Contraseña: $editContra",
                                style: TextStyle(
                                    color: _azul,
                                    fontSize: 13,
                                    fontFamily: 'Gotham Pro')),
                            editRol == 1
                                ? Text("Rol: Administrador",
                                    style: TextStyle(
                                        color: _azul,
                                        fontSize: 13,
                                        fontFamily: 'Gotham Pro'))
                                : Text("Rol: Cliente",
                                    style: TextStyle(
                                        color: _azul,
                                        fontSize: 13,
                                        fontFamily: 'Gotham Pro')),
                          ],
                        )
                      ],
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 255, 149, 0),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          const EditarClienteScreen()));
                            },
                            label: const Text("Editar",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontFamily: 'Gotham Pro')),
                            icon: const Icon(Icons.edit,
                                color: Colors.white, size: 30),
                            iconAlignment: IconAlignment.start,
                          ),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 255, 149, 0),
                            ),
                            onPressed: () {
                              eliminarUsuario(editDocumentId);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Usuario eliminado'),
                                ),
                              );
                              Navigator.pop(context);
                            },
                            label: const Text("Eliminar",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontFamily: 'Gotham Pro')),
                            icon: const Icon(Icons.delete,
                                color: Colors.white, size: 30),
                            iconAlignment: IconAlignment.start,
                          ),
                        ]),
                    const Divider(),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _naranja,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      label: const Text("Regresar",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'Gotham Pro')),
                      icon: const Icon(Icons.arrow_back,
                          color: Colors.white, size: 30),
                      iconAlignment: IconAlignment.start,
                    ),
                  ],
                ),
              ],
            )));
  }
}
