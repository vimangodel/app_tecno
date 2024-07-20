import 'package:app_tecno/pantallas/compra_screen.dart';
import 'package:app_tecno/pantallas/home_screen.dart';
import 'package:app_tecno/pantallas/register_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class FormIniSesion extends StatefulWidget {
  const FormIniSesion({super.key});

  @override
  State<FormIniSesion> createState() => _FormIniSesionState();
}

class _FormIniSesionState extends State<FormIniSesion> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  late final GlobalKey<FormState> _formularioEstado;
  late bool _passwordVisible;
  late Color _azul;
  late Color _naranja;
  late String _user;
  late String _pass;
  late TextEditingController _usuarioController;
  late TextEditingController _contraController;

  Future<void> getUserContra() async {
    String usuario = "";
    String contra = "";

    CollectionReference collectionReferencePeople = db.collection('usuarios');

    QuerySnapshot queryUsuarios = await collectionReferencePeople.get();

    queryUsuarios.docs.forEach((documento) {
      if (documento['usuario'] == _usuarioController.text) {
        usuario = documento['usuario'];
        contra = documento['contra'];
      }
    });

    _user = usuario;
    _pass = contra;
  }

  @override
  void initState() {
    _formularioEstado = GlobalKey<FormState>();
    _passwordVisible = true;
    _azul = const Color.fromARGB(255, 0, 60, 121);
    _naranja = const Color.fromARGB(255, 255, 149, 0);
    _user = "";
    _pass = "";
    _usuarioController = TextEditingController();
    _contraController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      constraints: BoxConstraints.tightForFinite(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.45),
      width: 350,
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      child: Form(
        key: _formularioEstado,
        child: ListView(
          children: [
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                ),
                child: TextFormField(
                  controller: _usuarioController,
                  onChanged: (value) {
                    getUserContra();
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Ingrese un usuario";
                    }
                    if (value != _user) {
                      return "Usuario no válido";
                    }
                    return null; //todo salio bien
                  },
                  decoration: InputDecoration(
                      label: Text("Usuario",
                          style: TextStyle(
                            color: _azul,
                            fontFamily: 'Gotham Pro Medium',
                            fontWeight: FontWeight.w400,
                          )),
                      hintText: "Usuario",
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
                    if (value!.isEmpty) {
                      return "Ingrese una contraseña";
                    }
                    if (value != _pass) {
                      return "La contraseña no coincide";
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
                margin: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: _naranja,
                      padding: const EdgeInsets.symmetric(
                          vertical: 13, horizontal: 30)),
                  onPressed: () {
                    if (_formularioEstado.currentState!.validate()) {
                      if (_user == _usuarioController.text &&
                          _pass == _contraController.text) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CompraScreen()));
                      } else {
                        print("Usuario o contraseña incorrectos");
                      }
                    } else {
                      print("Algo salió mal");
                    }
                  },
                  child: Text("INICIAR SESIÓN",
                      style: TextStyle(
                          color: _azul,
                          fontFamily: 'Gotham Pro',
                          fontWeight: FontWeight.w900)),
                )),
            Container(
                child: TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegisterScreen()));
              },
              child: Text("¿No tienes cuenta? Regístrate",
                  style: TextStyle(
                      color: _azul,
                      fontFamily: 'Gotham Pro Medium',
                      fontWeight: FontWeight.w600)),
            ))
          ],
        ),
      ),
    ));
  }
}
