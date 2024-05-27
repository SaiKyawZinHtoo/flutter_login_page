import 'dart:io';
import 'package:exercise_login_page/services/firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../models/item.dart';

class ItemDetailScreen extends StatefulWidget {
  final Item item;

  const ItemDetailScreen({Key? key, required this.item}) : super(key: key);

  @override
  _ItemDetailScreenState createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  String _imageUrl = '';
  XFile? _pickedFile;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.item.name);
    _descriptionController =
        TextEditingController(text: widget.item.description);
    _imageUrl = widget.item.imageUrl;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _pickedFile = pickedFile;
      });
    }
  }

  Future<void> _uploadImage() async {
    if (_pickedFile == null) return;

    final Reference storageRef =
        FirebaseStorage.instance.ref().child('images/${widget.item.id}');
    final uploadTask = storageRef.putFile(File(_pickedFile!.path));

    try {
      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();
      setState(() {
        _imageUrl = downloadUrl;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Image uploaded successfully!')),
      );
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload image: $e')),
      );
    }
  }

  void _saveItem() {
    final updatedItem = Item(
      id: widget.item.id.isEmpty ? DateTime.now().toString() : widget.item.id,
      name: _nameController.text,
      description: _descriptionController.text,
      imageUrl: _imageUrl,
    );
    if (widget.item.id.isEmpty) {
      FirestoreService().addItem(updatedItem);
    } else {
      FirestoreService().updateItem(updatedItem);
    }
    Navigator.pop(context);
  }

  void _deleteItem() {
    FirestoreService().deleteItem(widget.item.id);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item.id.isEmpty ? 'Add Item' : 'Edit Item'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 4,
            ),
            const SizedBox(height: 10),
            _imageUrl.isEmpty
                ? _pickedFile != null
                    ? Image.file(File(_pickedFile!.path), height: 200)
                    : const Placeholder(fallbackHeight: 200)
                : Image.network(_imageUrl, height: 200),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Pick Image'),
            ),
            ElevatedButton(
              onPressed: _uploadImage,
              child: const Text('Upload Image'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveItem,
              child: const Text('Save'),
            ),
            if (widget.item.id.isNotEmpty)
              ElevatedButton(
                onPressed: _deleteItem,
                child: const Text('Delete'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}
