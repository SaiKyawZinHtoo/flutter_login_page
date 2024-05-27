import 'package:exercise_login_page/services/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/item.dart';
import '../widgets/item_list_tile.dart';
import 'item_detail_screen.dart';

class HomePage extends StatelessWidget {
  //sign user out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        title: Text('My Home Page Note'),
        actions: [IconButton(onPressed: signUserOut, icon: Icon(Icons.logout))],
      ),
      body: StreamProvider<List<Item>>.value(
        value: FirestoreService().getItems(),
        initialData: [],
        child: Consumer<List<Item>>(
          builder: (context, items, child) {
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ItemListTile(
                  item: items[index],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ItemDetailScreen(item: items[index]),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ItemDetailScreen(
                  item: Item(id: '', name: '', description: '', imageUrl: '')),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
