// ignore: depend_on_referenced_packages
import 'package:cloud_firestore/cloud_firestore.dart';

class Item {
  String id;
  String name;
  String description;
  String imageUrl;

  Item(
      {required this.id,
      required this.name,
      required this.description,
      required this.imageUrl});

  factory Item.fromDocument(DocumentSnapshot doc) {
    return Item(
      id: doc.id,
      name: doc['name'],
      description: doc['description'],
      imageUrl: doc['imageUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
    };
  }
}
