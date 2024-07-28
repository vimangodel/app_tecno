import 'package:app_tecno/pantallas/cliente_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app_tecno/sistema/globales.dart';

import 'package:flutter/material.dart';

class FormClientes extends StatefulWidget {
  const FormClientes({super.key});

  @override
  State<FormClientes> createState() => _FormClientesState();
}

class _FormClientesState extends State<FormClientes> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  late final GlobalKey<FormState> _formularioEstado;
  late TextEditingController _usuarioController;
  late TextEditingController _fechaController;
  late Color _azul;
  late Color _naranja;
  late Color _celeste;
  late String _user;
  late DateTimeRange _fechaRegistro;

  Future<List> getUsers() async {
    List users = [];
    CollectionReference collectionReferencePeople = db.collection('usuarios');

    QuerySnapshot queryUsuarios = await collectionReferencePeople.get();

    for (var documento in queryUsuarios.docs) {
      final Map<String, dynamic> data =
          documento.data() as Map<String, dynamic>;
      final fechaRegistroDateTime = data['fecha_registro'].toDate();
      final person = {
        'usuario': data['usuario'],
        'nombre': data['nombre'],
        'apellidos': data['apellidos'],
        'correo': data['correo'],
        'telefono': data['telefono'],
        'direccion': data['direccion'],
        'rol': data['rol'],
        'contra': data['contra'],
        'id': documento.id,
      };

      if (documento['usuario'] == _user) {
        users.add(person);
      }
      if ((_fechaRegistro.start.isBefore(fechaRegistroDateTime) &&
          _fechaRegistro.end.isAfter(fechaRegistroDateTime))) {
        users.add(person);
      }
    }
    return users;
  }

  @override
  void initState() {
    _formularioEstado = GlobalKey<FormState>();
    _azul = const Color.fromARGB(255, 0, 60, 121);
    _naranja = const Color.fromARGB(255, 255, 149, 0);
    _celeste = const Color.fromARGB(255, 0, 191, 255);
    _usuarioController = TextEditingController();
    _fechaController = TextEditingController();
    _fechaRegistro = DateTimeRange(start: DateTime.now(), end: DateTime.now());
    _user = "";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formularioEstado,
      child: Column(
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 20, left: 20),
              width: 325,
              height: 70,
              child: TextFormField(
                controller: _usuarioController,
                decoration: InputDecoration(
                  label: Text("Usuario",
                      style: TextStyle(
                        color: _azul,
                        fontFamily: 'Gotham Pro Medium',
                        fontWeight: FontWeight.w400,
                      )),
                  hintText: "Usuario",
                  prefixIcon: const Icon(Icons.person),
                  prefixIconColor: _azul,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: _naranja, width: 2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  _fechaController.text = "";
                },
              ),
            ),
          ),
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 20, left: 20),
              width: 325,
              height: 70,
              child: TextFormField(
                controller: _fechaController,
                decoration: InputDecoration(
                  label: Text("Rango de fecha",
                      style: TextStyle(
                        color: _azul,
                        fontFamily: 'Gotham Pro Medium',
                        fontWeight: FontWeight.w400,
                      )),
                  hintText: "Fecha de inicio",
                  prefixIcon: const Icon(Icons.calendar_today),
                  prefixIconColor: _azul,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: _naranja, width: 2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  border: InputBorder.none,
                ),
                readOnly: true,
                onTap: () {
                  _mostrarFecha();
                  _usuarioController.text = "";
                },
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: _naranja,
            ),
            onPressed: () {
              setState(() {
                getUsers();
              });
              if (_formularioEstado.currentState!.validate()) {
                _user = _usuarioController.text;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Buscando usuarios...'),
                  ),
                );
              }
            },
            label: const Text("Consultar",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Gotham Pro')),
            icon: const Icon(Icons.search, color: Colors.white, size: 30),
            iconAlignment: IconAlignment.start,
          ),
          const Divider(),
          FutureBuilder(
              future: getUsers(),
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
                            title: Text(snapshot.data?[index]['usuario']),
                            subtitle: Row(
                              children: [
                                Text(snapshot.data?[index]['nombre']),
                                const Text(" "),
                                Text(snapshot.data?[index]['apellidos']),
                              ],
                            ),
                            onTap: () {
                              editNombre = snapshot.data?[index]['nombre'];
                              editApellidos =
                                  snapshot.data?[index]['apellidos'];
                              editUsuario = snapshot.data?[index]['usuario'];
                              editEmail = snapshot.data?[index]['correo'];
                              editTelefono = snapshot.data?[index]['telefono'];
                              editDireccion =
                                  snapshot.data?[index]['direccion'];
                              editRol = snapshot.data?[index]['rol'];
                              editContra = snapshot.data?[index]['contra'];
                              editDocumentId = snapshot.data?[index]['id'];

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const MostrarClienteScreen()));

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
      ),
    );
  }

  Future<void> _mostrarFecha() async {
    final DateTimeRange? seleccion = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (seleccion != null) {
      setState(() {
        _fechaController.text = "${seleccion.start.toString().split(" ")[0]} / ${seleccion.end.toString().split(" ")[0]}";
        _fechaRegistro = seleccion;
      });
    }
  }
}
