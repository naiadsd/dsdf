import 'package:dsd/models/item.dart';
import 'package:dsd/views/items/items.dart';
import 'package:flutter/material.dart';

class ItemList extends StatelessWidget {
  final Future<List<Item>> items;
  const ItemList({required this.items});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Items"),
          backgroundColor: Colors.cyan,
          centerTitle: true,
        ),
        body: Center(
          child: FutureBuilder<List<Item>>(
            future: items,
            builder: (context, snapshot) {
              if (snapshot.hasError) {}
              return snapshot.hasData
                  ? Items(items: snapshot.data ?? [])
                  : const Center(child: CircularProgressIndicator());
            },
          ),
        ));
  }
}
