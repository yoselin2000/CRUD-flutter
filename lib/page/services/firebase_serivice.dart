import "package:cloud_firestore/cloud_firestore.dart";

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getUser() async {
  List user = [];
  QuerySnapshot querySnapshot = await db.collection('user').get();
  for (var doc in querySnapshot.docs) {
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final usuario = {
      "name": data['name'],
      "matchReceptor": data['matchReceptor'],
      "matchSelector": data['matchSelector'],
      "uid": doc.id,
    };
    user.add(usuario);
  }
  //await Future.delayed(const Duration(seconds: 5));

  return user;
}

Future<void> addUser(String name, String matchReceptor, String matchSelector,) async {
  await db.collection('user').add({"name": name, "matchReceptor": matchReceptor, "matchSelector ": matchSelector},);
}

Future<void> updateUser(String uid, String newName) async {
  await db.collection('user').doc(uid).set({"name": newName, });
}

Future<void> deleteUser(String uid) async {
  await db.collection('user').doc(uid).delete();
}



//prueba de eliminacion de campos repetidos
Future<void> deleteDuplicateDocuments(String fieldName) async {
  QuerySnapshot querySnapshot = await db.collection('user').get();
  Map<String, String> uniqueValues = {};

  for (QueryDocumentSnapshot doc in querySnapshot.docs) {
    String fieldValue = doc.get(fieldName);

    if (uniqueValues.containsKey(fieldValue)) {
      print('Documento eliminado con ID: ${doc.id}');
      print('Contenido del documento eliminado: ${doc.data()}');
      await db.collection('user').doc(doc.id).delete();
    } else {
      uniqueValues[fieldValue] = doc.id;
    }
  }
}

Future<void> deleteDuplicateMatches() async {
  QuerySnapshot querySnapshot = await db.collection('user').get();
  Map<String, String> uniqueValues = {};

  for (QueryDocumentSnapshot doc in querySnapshot.docs) {
    final data = doc.data() as Map<String, dynamic>;
    String? matchReceptor = data['matchReceptor'];
    String? matchSelector = data['matchSelector'];
    String uniqueKey = '${matchReceptor ?? 'unknown'}|${matchSelector ?? 'unknown'}'; // Crear una clave única combinando ambos campos

    if (uniqueValues.containsKey(uniqueKey)) {
      print('Documento eliminado con ID: ${doc.id}');
      print('Contenido del documento eliminado: ${doc.data()}');
      await db.collection('user').doc(doc.id).delete();
    } else {
      uniqueValues[uniqueKey] = doc.id;
    }
  }
}

