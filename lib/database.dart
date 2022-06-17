import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';


final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('clients');
class database {
static String clientId = 'd';

static Future<void> addItem({
  required String description,
  required String clientId,
  required var quantity,
  required var itemPrice,
}) async {
  DocumentReference documentReferencer =
      _mainCollection.doc(clientId);

  Map<String, dynamic> data = <String, dynamic>{
    "description": description,
    "quantity": quantity,
    "itemprice": itemPrice,
  };

  await documentReferencer
      .set(data)
      .whenComplete(() => print("Notes item added to the database"))
      .catchError((e) => print(e));
}
static Stream<QuerySnapshot<Object?>> readItems() {
  CollectionReference clientsItemCollection =
      _mainCollection.doc(clientId).collection('clients');

  return clientsItemCollection.snapshots();
}


static Future<void> deleteItem({
  required String docId,
}) async {
  DocumentReference documentReferencer =
      _mainCollection.doc(clientId);

  await documentReferencer
      .delete()
      .whenComplete(() => print('Note item deleted from the database'))
      .catchError((e) => print(e));
}
static Future<void> updateItem({
  required String description,
  required String clientId,
  required var quantity,
  required var itemPrice,
}) async {
  DocumentReference documentReferencer =
      _mainCollection.doc(clientId);

  Map<String, dynamic> data = <String, dynamic>{
    "description": description,
    "quantity": quantity,
    "itemprice": itemPrice,
  };

  await documentReferencer
      .update(data)
      .whenComplete(() => print("Note item updated in the database"))
      .catchError((e) => print(e));
}

}