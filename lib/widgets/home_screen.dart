import 'package:app_tecno/pantallas/inicio_sesion_screen.dart';
import 'package:app_tecno/pantallas/register_screen.dart';
import 'package:flutter/material.dart';

class HomeScreenWidget extends StatefulWidget {
  const HomeScreenWidget({super.key});

  @override
  State<HomeScreenWidget> createState() => _HomeScreenWidgetState();
}

class _HomeScreenWidgetState extends State<HomeScreenWidget> {
  late Color _color1;

  @override
  void initState() {
    _color1 = const Color.fromARGB(255, 0, 60, 121);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          Container(
            height: 200,
            margin: const EdgeInsets.only(bottom: 30),
            child: Image.asset('assets/img/logo.png'),
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: _color1),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const IniSesionScreen()));
              },
              child: const Text(
                'INICIAR SESIÓN',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Gotham Pro',
                    fontWeight: FontWeight.w900),
              )),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: _color1),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RegisterScreen()));
            },
            child: const Text('REGISTRARME',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Gotham Pro',
                    fontWeight: FontWeight.w900)),
          ),
        ]));
  }
}
