import 'package:flutter/material.dart';
import '../models/item.dart';

class ItemListTile extends StatelessWidget {
  final Item item;
  final VoidCallback onTap;

  ItemListTile({required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.name),
      subtitle: Text(item.description),
      trailing: item.imageUrl.isNotEmpty
          ? Image.network(item.imageUrl, width: 50)
          : null,
      onTap: onTap,
    );
  }
}
