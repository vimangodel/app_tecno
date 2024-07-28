import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class Informacion extends StatefulWidget {
  const Informacion({super.key});

  @override
  State<Informacion> createState() => _InformacionState();
}

class _InformacionState extends State<Informacion> {
  final Color _celeste = const Color.fromARGB(255, 0, 176, 242);
  FirebaseStorage storage = FirebaseStorage.instance;
  String _url = '';

  Future<void> getFoto() async {
    final ref = storage.ref().child('tienda.jpg');
    final downloadUrl = await ref.getDownloadURL();
    setState(() {
      _url = downloadUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      getFoto();
    });
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: ListView(
          children: [
            Text("¿Quiénes somos?",
                style: TextStyle(
                    fontSize: 40,
                    color: _celeste,
                    fontFamily: 'Gotham Medium',
                    fontWeight: FontWeight.w900)),
            _url == ''
                ? const CircularProgressIndicator()
                : Image.network(_url,
                    width: MediaQuery.of(context).size.width * 0.9),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: _celeste,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                  "Tu destino confiable para electrodomésticos de última generación. Ofrecemos una amplia gama de productos, desde televisores y refrigeradores hasta lavadoras y más, con las mejores marcas y tecnología avanzada. Nuestro compromiso es brindarte calidad, innovación y un servicio al cliente excepcional para que encuentres lo que necesitas para tu hogar con facilidad.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                      fontFamily: 'Gotham Medium',
                      fontWeight: FontWeight.w500)),
            ),
          ],
        ),
      ),
    );
  }
}
