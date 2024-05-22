import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exercise_login_page/services/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;

  //firebase store
  final FirestoreService firestoreService = FirestoreService();
  //text Controller
  final TextEditingController textController = TextEditingController();

  // open dialog box
  void openNoteBox({String? docId}) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              //text user input
              content: TextField(
                controller: textController,
              ),
              actions: [
                //button to save
                ElevatedButton(
                    onPressed: () {
                      //add new note
                      if (docId == null) {
                        firestoreService.addNote(textController.text);
                      }
                      // update and existing note
                      else {
                        firestoreService.updateNote(docId, textController.text);
                      }
                      // clear the text controller
                      textController.clear();

                      //close the box
                      Navigator.pop(context);
                    },
                    child: Text('Add'))
              ],
            ));
  }

  //sign user out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        title: const Text('Note Home Page'),
        actions: [IconButton(onPressed: signUserOut, icon: Icon(Icons.logout))],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: openNoteBox,
        child: const Icon(Icons.add),
      ),
      // body: Center(
      //   child: Text(
      //     "LOGGED IN AS: " + user.email!,
      //     style: TextStyle(fontSize: 20),
      //   ),
      // ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestoreService.getNoteStream(),
        builder: (context, snapshot) {
          //if we have data, we get all doc
          if (snapshot.hasData) {
            List notesList = snapshot.data!.docs;

            //display as a list
            return ListView.builder(
                itemCount: notesList.length,
                itemBuilder: (context, index) {
                  //get each individual doc
                  DocumentSnapshot document = notesList[index];
                  String docId = document.id;

                  //get note form each doc
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  String noteText = data['note'];

                  //display as a list tile
                  return ListTile(
                    title: Text(noteText),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          //update button
                          onPressed: () => openNoteBox(docId: docId),
                          icon: const Icon(Icons.settings),
                        ),

                        //delete Button
                        IconButton(
                          onPressed: () => firestoreService.deleteNote(docId),
                          icon: const Icon(Icons.delete),
                        )
                      ],
                    ),
                  );
                });
          }
          //if there is no data return nothing
          else {
            return const Text("No Notes..");
          }
        },
      ),
    );
  }
}
