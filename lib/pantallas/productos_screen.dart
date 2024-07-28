import 'package:app_tecno/widgets/productos.dart';
import 'package:flutter/material.dart';

class MostrarProductosScreen extends StatefulWidget {
  const MostrarProductosScreen({super.key});

  @override
  State<MostrarProductosScreen> createState() => _MostrarProductosScreenState();
}

class _MostrarProductosScreenState extends State<MostrarProductosScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Productos(),
      ),
    );
  }
}
