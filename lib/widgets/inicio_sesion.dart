import 'package:flutter/material.dart';

class FormIniSesion extends StatefulWidget {
  const FormIniSesion({super.key});

  @override
  State<FormIniSesion> createState() => _FormIniSesionState();
}

class _FormIniSesionState extends State<FormIniSesion> {
  late final GlobalKey<FormState> _formularioEstado;
  late bool _passwordVisible;
  late Color _azul;
  late Color _naranja;

  @override
  void initState() {
    _formularioEstado = GlobalKey<FormState>();
    _passwordVisible = true;
    _azul = const Color.fromARGB(255, 0, 60, 121);
    _naranja = const Color.fromARGB(255, 255, 149, 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      constraints: BoxConstraints.tightForFinite(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.4),
      width: 350,
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      child: Form(
        key: _formularioEstado,
        child: Column(
          children: [
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                ),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Ingrese un usuario";
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
                margin: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: _naranja,
                      padding: const EdgeInsets.symmetric(
                          vertical: 13, horizontal: 30)),
                  onPressed: () {
                    if (_formularioEstado.currentState!.validate()) {
                      print("Todo salió bien");
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
              onPressed: () {},
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
