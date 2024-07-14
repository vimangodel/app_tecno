import 'package:app_tecno/widgets/registro.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: const MaterialColor(0xFF002F79, <int, Color>{}),
            title: const Center(
              child: Text('REGISTRO DE USUARIO',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      fontFamily: 'Gotham Pro')),
            )),
        body: const FormRegistro(),
        backgroundColor: const MaterialColor(0xFF002F79, <int, Color>{}));
  }
}
