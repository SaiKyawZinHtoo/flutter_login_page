import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/item.dart';

class FirestoreService {
  final CollectionReference _itemsCollection =
      FirebaseFirestore.instance.collection('items');

  Future<void> addItem(Item item) async {
    await _itemsCollection.add(item.toMap());
  }

  Future<void> updateItem(Item item) async {
    await _itemsCollection.doc(item.id).update(item.toMap());
  }

  Future<void> deleteItem(String id) async {
    await _itemsCollection.doc(id).delete();
  }

  Stream<List<Item>> getItems() {
    return _itemsCollection.snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Item.fromDocument(doc)).toList());
  }
}
