import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Contactos extends StatefulWidget {
  const Contactos({super.key});

  @override
  State<Contactos> createState() => _ContactosState();
}

class _ContactosState extends State<Contactos> {
  FirebaseStorage storage = FirebaseStorage.instance;
  final Color _naranja = const Color.fromARGB(255, 255, 149, 0);
  final Color _celeste = const Color.fromARGB(255, 0, 176, 242);
  final Color _azul = const Color.fromARGB(255, 0, 60, 121);
  String _urlFacebok = '';
  String _urlInstagram = '';
  String _urlX = '';
  String _urlWhatsapp = '';

  Future<void> getFacebook() async {
    final ref = storage.ref().child('facebook.png');
    final downloadUrl = await ref.getDownloadURL();
    setState(() {
      _urlFacebok = downloadUrl;
    });
  }

  Future<void> getX() async {
    final ref = storage.ref().child('x.png');
    final downloadUrl = await ref.getDownloadURL();
    setState(() {
      _urlX = downloadUrl;
    });
  }

  Future<void> getInstagram() async {
    final ref = storage.ref().child('instagram.png');
    final downloadUrl = await ref.getDownloadURL();
    setState(() {
      _urlInstagram = downloadUrl;
    });
  }

  Future<void> getWhatsapp() async {
    final ref = storage.ref().child('whatsapp.png');
    final downloadUrl = await ref.getDownloadURL();
    setState(() {
      _urlWhatsapp = downloadUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      getFacebook();
      getInstagram();
      getX();
      getWhatsapp();
    });
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.8,
      child: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    Icon(
                      Icons.mail_outline,
                      color: _celeste,
                      size: 40,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      "tecnohouse@gmail.com",
                      style: TextStyle(
                          color: _azul,
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                          fontFamily: 'Gotham Medium'),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    Icon(
                      Icons.location_on_sharp,
                      color: _celeste,
                      size: 40,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Km 5 1/2 Vía a Daule - Yaguachi",
                      style: TextStyle(
                          color: _azul,
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                          fontFamily: 'Gotham Medium'),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    Icon(
                      Icons.phone_in_talk,
                      color: _celeste,
                      size: 40,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      "09 84438923",
                      style: TextStyle(
                          color: _azul,
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                          fontFamily: 'Gotham Medium'),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                "Redes Sociales",
                style: TextStyle(
                    color: _celeste,
                    fontWeight: FontWeight.w700,
                    fontSize: 30,
                    fontFamily: 'Gotham Medium'),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _urlFacebok == ''
                        ? const CircularProgressIndicator()
                        : Image.network(_urlFacebok, width: 50, height: 50),
                    _urlInstagram == ''
                        ? const CircularProgressIndicator()
                        : Image.network(_urlInstagram, width: 50, height: 50),
                    _urlX == ''
                        ? const CircularProgressIndicator()
                        : Image.network(_urlX, width: 50, height: 50),
                    _urlWhatsapp == ''
                        ? const CircularProgressIndicator()
                        : Image.network(_urlWhatsapp, width: 50, height: 50),
                  ],
                ),
              )
            ]),
      ),
    );
  }
}
