import 'package:app_tecno/pantallas/inicio_sesion_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FormRegistro extends StatefulWidget {
  const FormRegistro({super.key});

  @override
  State<FormRegistro> createState() => _FormularioRegistroState();
}

class _FormularioRegistroState extends State<FormRegistro> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  late CollectionReference usuarios;
  late final GlobalKey<FormState> _formularioEstado;
  late bool _passwordVisible;
  late Color _azul;
  late Color _naranja;
  late String user;
  late List listaUsers;
  late TextEditingController _nombreController;
  late TextEditingController _apellidosController;
  late TextEditingController _usuarioController;
  late TextEditingController _correoController;
  late TextEditingController _telefonoController;
  late TextEditingController _direccionController;
  late TextEditingController _contraController;

  Future<void> agregarUsuario() async {
    String nombre = _nombreController.text;
    String apellidos = _apellidosController.text;
    String usuario = _usuarioController.text;
    user = usuario;
    String correo = _correoController.text;
    String telefono = _telefonoController.text;
    String direccion = _direccionController.text;
    String contra = _contraController.text;
    DateTime fecha = DateTime.now();
    if (_formularioEstado.currentState!.validate()) {
      await usuarios.add({
        'nombre': nombre,
        'apellidos': apellidos,
        'usuario': usuario,
        'correo': correo,
        'telefono': telefono,
        'direccion': direccion,
        'contra': contra,
        'fecha_registro': fecha,
        'rol': 2
      });
    }
  }

  Future<void> getUsuarios() async {
    List listaUsuarios = [];

    CollectionReference collectionReferencePeople = db.collection('usuarios');

    QuerySnapshot queryUsuarios = await collectionReferencePeople.get();

    queryUsuarios.docs.forEach((documento) {
      listaUsuarios.add(documento['usuario']);
    });

    listaUsers = listaUsuarios;
  }

  @override
  void initState() {
    _formularioEstado = GlobalKey<FormState>();
    _passwordVisible = true;
    _azul = const Color.fromARGB(255, 0, 60, 121);
    _naranja = const Color.fromARGB(255, 255, 149, 0);
    usuarios = db.collection('usuarios');
    _nombreController = TextEditingController();
    _apellidosController = TextEditingController();
    _usuarioController = TextEditingController();
    _correoController = TextEditingController();
    _telefonoController = TextEditingController();
    _direccionController = TextEditingController();
    _contraController = TextEditingController();
    user = "";
    listaUsers = [];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      constraints: BoxConstraints.tightForFinite(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.9),
      width: 350,
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      child: Form(
        key: _formularioEstado,
        child: ListView(
          children: [
            Container(
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
                  controller: _usuarioController,
                  onChanged: (value) {
                    getUsuarios();
                    print(listaUsers);
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Ingrese un usuario";
                    }
                    if (value.contains(' ')) {
                      return "El usuario no puede contener espacios";
                    }
                    if (listaUsers.contains(value)) {
                      return "El usuario ya existe debes elegir otro";
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
                padding: const EdgeInsets.symmetric(horizontal: 10),
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                ),
                child: TextFormField(
                  obscureText: _passwordVisible,
                  validator: (value) {
                    if (value != _contraController.text) {
                      return "La contraseña no coincide";
                    }
                    return null; //todo salio bien
                  },
                  decoration: InputDecoration(
                    label: Text("Repetir contraseña",
                        style: TextStyle(
                          color: _azul,
                          fontFamily: 'Gotham Pro Medium',
                          fontWeight: FontWeight.w400,
                        )),
                    hintText: "Repetir contraseña",
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
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                              Text("Usuario $user registrado correctamente")));
                      agregarUsuario();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const IniSesionScreen()));
                    } else {
                      print("Algo salió mal");
                    }
                  },
                  child: Text("REGISTRARME",
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
                        builder: (context) => const IniSesionScreen()));
              },
              child: Text("¿Ya tienes una cuenta? Inicia sesión",
                  style: TextStyle(
                      color: _azul,
                      fontFamily: 'Gotham Pro Medium',
                      fontWeight: FontWeight.w600)),
            )),
          ],
        ),
      ),
    ));
  }
}
