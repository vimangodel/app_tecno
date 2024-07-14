import 'package:app_tecno/widgets/inicio_sesion.dart';
import 'package:flutter/material.dart';

class IniSesionScreen extends StatelessWidget {
  const IniSesionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: const MaterialColor(0xFF002F79, <int, Color>{}),
            title: const Center(
              child: Text('INICIAR SESIÓN',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      fontFamily: 'Gotham Pro')),
            )),
        body: const FormIniSesion(),
        backgroundColor: const MaterialColor(0xFF002F79, <int, Color>{}));
  }
}
