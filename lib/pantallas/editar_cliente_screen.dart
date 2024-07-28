import 'package:app_tecno/widgets/editar_cliente.dart';
import 'package:flutter/material.dart';

class EditarClienteScreen extends StatefulWidget {
  const EditarClienteScreen({super.key});

  @override
  State<EditarClienteScreen> createState() => _EditarClienteScreenState();
}

class _EditarClienteScreenState extends State<EditarClienteScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: EditarCliente()),
    );
  }
}
