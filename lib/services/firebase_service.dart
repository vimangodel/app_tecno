import "package:cloud_firestore/cloud_firestore.dart";

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getUsuarios() async {
  List usuarios = [];

  CollectionReference collectionReferencePeople = db.collection('usuarios');

  QuerySnapshot queryUsuarios = await collectionReferencePeople.get();

  queryUsuarios.docs.forEach((documento) {
    usuarios.add(documento.data());
  });

  return usuarios;
}
