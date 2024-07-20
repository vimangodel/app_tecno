import 'package:app_tecno/widgets/registro.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("REGISTRO DE USUARIO",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 28,
                    color: Colors.white,
                    fontFamily: 'Gotham Pro')),
            FormRegistro()
          ],
        ),
        backgroundColor: MaterialColor(0xFF002F79, <int, Color>{}));
  }
}
