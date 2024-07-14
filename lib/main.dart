import 'package:app_tecno/pantallas/home_screen.dart';
import 'package:app_tecno/pantallas/register_screen.dart';
import 'package:app_tecno/pantallas/inicio_sesion_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Gotham Pro Black',
      ),
      title: 'Material App',
      home: const RegisterScreen(),
    );
  }
}
