import 'package:app_tecno/pantallas/main_screen.dart';
import 'package:app_tecno/sistema/globales.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class EditarCliente extends StatefulWidget {
  const EditarCliente({super.key});

  @override
  State<EditarCliente> createState() => _EditarClienteState();
}

class _EditarClienteState extends State<EditarCliente> {
  final GlobalKey<FormState> _formularioEstado = GlobalKey<FormState>();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidosController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _direccionController = TextEditingController();
  final TextEditingController _contraController = TextEditingController();
  bool _passwordVisible = false;
  final Color _naranja = const Color.fromARGB(255, 255, 149, 0);
  final Color _azul = const Color.fromARGB(255, 0, 60, 121);
  String id = "";

  @override
  Widget build(BuildContext context) {
    _nombreController.text = editNombre;
    _apellidosController.text = editApellidos;
    _correoController.text = editEmail;
    _telefonoController.text = editTelefono;
    _direccionController.text = editDireccion;
    _contraController.text = editContra;

    return Center(
        child: Container(
      color: Colors.white,
      margin: const EdgeInsets.all(20),
      width: 325,
      child: Form(
        key: _formularioEstado,
        child: ListView(
          children: [
            Center(
                child: Text("Edición del cliente $editUsuario",
                    style: TextStyle(
                        color: _azul,
                        fontSize: 20,
                        fontFamily: 'Gotham Pro Medium',
                        fontWeight: FontWeight.w900))),
            Container(
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                ),
                child: TextFormField(
                  controller: _nombreController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Ingrese su nombre";
                    }
                    return null; //todo salio bien
                  },
                  decoration: InputDecoration(
                      label: Text("Nombre",
                          style: TextStyle(
                            color: _azul,
                            fontFamily: 'Gotham Pro Medium',
                            fontWeight: FontWeight.w400,
                          )),
                      hintText: "Nombre",
                      border: InputBorder.none),
                )),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                ),
                child: TextFormField(
                  controller: _apellidosController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Ingrese sus apellidos";
                    }
                    return null; //todo salio bien
                  },
                  decoration: InputDecoration(
                      label: Text("Apellidos",
                          style: TextStyle(
                            color: _azul,
                            fontFamily: 'Gotham Pro Medium',
                            fontWeight: FontWeight.w400,
                          )),
                      hintText: "Apellidos",
                      border: InputBorder.none),
                )),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                ),
                child: TextFormField(
                  controller: _correoController,
                  validator: (value) {
                    if (!value!.contains("@") || !value.contains(".")) {
                      return "El correo no es válido";
                    }
                    return null; //todo salio bien
                  },
                  decoration: InputDecoration(
                      label: Text("Correo electrónico",
                          style: TextStyle(
                            color: _azul,
                            fontFamily: 'Gotham Pro Medium',
                            fontWeight: FontWeight.w400,
                          )),
                      hintText: "Correo electrónico",
                      border: InputBorder.none),
                )),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                ),
                child: TextFormField(
                  controller: _telefonoController,
                  validator: (value) {
                    if (value!.isEmpty ||
                        value.length < 10 ||
                        value.length > 10 ||
                        !value.contains(RegExp(r'[0-9]'))) {
                      return "Ingrese un número de teléfono válido";
                    }
                    return null; //todo salio bien
                  },
                  decoration: InputDecoration(
                      label: Text("Teléfono",
                          style: TextStyle(
                            color: _azul,
                            fontFamily: 'Gotham Pro Medium',
                            fontWeight: FontWeight.w400,
                          )),
                      hintText: "Teléfono",
                      border: InputBorder.none),
                )),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                ),
                child: TextFormField(
                  controller: _direccionController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Ingrese su dirección";
                    }
                    return null; //todo salio bien
                  },
                  decoration: InputDecoration(
                      label: Text("Dirección",
                          style: TextStyle(
                            color: _azul,
                            fontFamily: 'Gotham Pro Medium',
                            fontWeight: FontWeight.w400,
                          )),
                      hintText: "Dirección",
                      border: InputBorder.none),
                )),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                ),
                child: TextFormField(
                  controller: _contraController,
                  obscureText: _passwordVisible,
                  validator: (value) {
                    if (value!.length < 8) {
                      return "La contraseña debe tener al menos 8 caracteres";
                    }
                    if (!value.contains(RegExp(r'[0-9]'))) {
                      return "La contraseña debe tener al menos un número";
                    }
                    if (!value.contains(RegExp(r'[a-z]'))) {
                      return "La contraseña debe tener al menos una letra minúscula";
                    }
                    if (!value.contains(RegExp(r'[A-Z]'))) {
                      return "La contraseña debe tener al menos una letra mayúscula";
                    }
                    return null; //todo salio bien
                  },
                  decoration: InputDecoration(
                    label: Text("Contraseña",
                        style: TextStyle(
                          color: _azul,
                          fontFamily: 'Gotham Pro Medium',
                          fontWeight: FontWeight.w400,
                        )),
                    hintText: "Contraseña",
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                        padding: const EdgeInsetsDirectional.only(end: 12),
                        icon: Icon(_passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        }),
                  ),
                )),
            Container(
                margin: const EdgeInsets.only(top: 10),
                child: Text("Selecciona el rol a actualizar",
                    style: TextStyle(
                        color: _azul,
                        fontSize: 20,
                        fontFamily: 'Gotham Pro Medium',
                        fontWeight: FontWeight.w900))),
            ListTile(
                title: Text("Cliente",
                    style: TextStyle(
                      color: _azul,
                      fontFamily: 'Gotham Pro Medium',
                      fontWeight: FontWeight.w400,
                    )),
                trailing: Radio(
                    value: 2,
                    groupValue: editRol,
                    onChanged: (value) {
                      setState(() {
                        if (value != null) {
                          editRol = value;
                        }
                      });
                    })),
            ListTile(
                title: Text("Administrador",
                    style: TextStyle(
                      color: _azul,
                      fontFamily: 'Gotham Pro Medium',
                      fontWeight: FontWeight.w400,
                    )),
                trailing: Radio(
                    value: 1,
                    groupValue: editRol,
                    onChanged: (value) {
                      setState(() {
                        if (value != null) {
                          editRol = value;
                        }
                      });
                    })),
            Container(
                margin: const EdgeInsets.only(top: 20),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _naranja,
                  ),
                  onPressed: () {
                    if (_formularioEstado.currentState!.validate()) {
                      actualizarClientes(editDocumentId);
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Cliente actualizado")));
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const MainScreen()));
                    }
                  },
                  label: const Text("Enviar",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Gotham Pro')),
                  icon: const Icon(Icons.send, color: Colors.white, size: 30),
                )),
            Container(
                margin: const EdgeInsets.only(top: 20),
                child: ElevatedButton.icon(
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
                )),
          ],
        ),
      ),
    ));
  }

  Future<void> actualizarClientes(id) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference usuarios = db.collection("usuarios");

    String nombre = _nombreController.text;
    String apellidos = _apellidosController.text;
    String correo = _correoController.text;
    String telefono = _telefonoController.text;
    String direccion = _direccionController.text;
    String contra = _contraController.text;
    int rol = editRol;

    await usuarios.doc(id).update({
      "nombre": nombre,
      "apellidos": apellidos,
      "correo": correo,
      "telefono": telefono,
      "direccion": direccion,
      "contra": contra,
      "rol": rol
    });
  }
}
