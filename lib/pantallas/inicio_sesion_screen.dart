import 'package:app_tecno/widgets/inicio_sesion.dart';
import 'package:flutter/material.dart';

class IniSesionScreen extends StatelessWidget {
  const IniSesionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("INICIO DE SESIÓN",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 28,
                    color: Colors.white,
                    fontFamily: 'Gotham Pro')),
            FormIniSesion()
          ],
        ),
        backgroundColor: MaterialColor(0xFF002F79, <int, Color>{}));
  }
}
