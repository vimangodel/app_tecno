import "package:cloud_firestore/cloud_firestore.dart";

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getUsuarios() async {
  List usuarios = [];

  CollectionReference collectionReferencePeople = db.collection('usuarios');

  QuerySnapshot queryUsuarios = await collectionReferencePeople.get();

  for (var documento in queryUsuarios.docs) {
    usuarios.add(documento.data());
  }

  return usuarios;
}
