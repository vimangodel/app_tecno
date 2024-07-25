import 'package:app_tecno/widgets/cliente.dart';
import 'package:flutter/material.dart';

class MostrarClienteScreen extends StatefulWidget {
  const MostrarClienteScreen({super.key});

  @override
  State<MostrarClienteScreen> createState() => _MostrarClienteState();
}

class _MostrarClienteState extends State<MostrarClienteScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Cliente(),
      ),
    );
  }
}
