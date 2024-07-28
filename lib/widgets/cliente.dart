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

    for (var documento in queryUsuarios.docs) {
      usuarios.doc(id).delete();
    }
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
                    Icon(Icons.person, size: 150, color: _azul),
                    ListTile(
                      title: Text("Nombre:",
                          style: TextStyle(
                              color: _azul,
                              fontSize: 20,
                              fontFamily: 'Gotham Medium',
                              fontWeight: FontWeight.w900)),
                      subtitle: Text(editNombre,
                          style: TextStyle(
                              color: _azul,
                              fontSize: 15,
                              fontFamily: 'Gotham Medium',
                              fontWeight: FontWeight.w600)),
                    ),
                    ListTile(
                      title: Text("Apellidos:",
                          style: TextStyle(
                              color: _azul,
                              fontSize: 20,
                              fontFamily: 'Gotham Medium',
                              fontWeight: FontWeight.w900)),
                      subtitle: Text(editApellidos,
                          style: TextStyle(
                              color: _azul,
                              fontSize: 15,
                              fontFamily: 'Gotham Medium',
                              fontWeight: FontWeight.w600)),
                    ),
                    ListTile(
                      title: Text("Email:",
                          style: TextStyle(
                              color: _azul,
                              fontSize: 20,
                              fontFamily: 'Gotham Medium',
                              fontWeight: FontWeight.w900)),
                      subtitle: Text(editEmail,
                          style: TextStyle(
                              color: _azul,
                              fontSize: 15,
                              fontFamily: 'Gotham Medium',
                              fontWeight: FontWeight.w600)),
                    ),
                    ListTile(
                      title: Text("Teléfono:",
                          style: TextStyle(
                              color: _azul,
                              fontSize: 20,
                              fontFamily: 'Gotham Medium',
                              fontWeight: FontWeight.w900)),
                      subtitle: Text(editTelefono,
                          style: TextStyle(
                              color: _azul,
                              fontSize: 15,
                              fontFamily: 'Gotham Medium',
                              fontWeight: FontWeight.w600)),
                    ),
                    ListTile(
                      title: Text("Dirección:",
                          style: TextStyle(
                              color: _azul,
                              fontSize: 20,
                              fontFamily: 'Gotham Medium',
                              fontWeight: FontWeight.w900)),
                      subtitle: Text(editDireccion,
                          style: TextStyle(
                              color: _azul,
                              fontSize: 15,
                              fontFamily: 'Gotham Medium',
                              fontWeight: FontWeight.w600)),
                    ),
                    ListTile(
                      title: Text("Contraseña:",
                          style: TextStyle(
                              color: _azul,
                              fontSize: 20,
                              fontFamily: 'Gotham Medium',
                              fontWeight: FontWeight.w900)),
                      subtitle: Text(editContra,
                          style: TextStyle(
                              color: _azul,
                              fontSize: 15,
                              fontFamily: 'Gotham Medium',
                              fontWeight: FontWeight.w600)),
                    ),
                    ListTile(
                      title: Text("Rol:",
                          style: TextStyle(
                              color: _azul,
                              fontSize: 20,
                              fontFamily: 'Gotham Medium',
                              fontWeight: FontWeight.w900)),
                      subtitle: editRol == 1
                          ? Text("Administrador",
                              style: TextStyle(
                                  color: _azul,
                                  fontSize: 15,
                                  fontFamily: 'Gotham Medium',
                                  fontWeight: FontWeight.w600))
                          : Text("Cliente",
                              style: TextStyle(
                                  color: _azul,
                                  fontSize: 15,
                                  fontFamily: 'Gotham Medium',
                                  fontWeight: FontWeight.w600)),
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
