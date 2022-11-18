import 'package:dsd/models/item.dart';
import 'package:dsd/views/item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Items extends StatelessWidget {
  final List<Item> items;
  const Items({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ItemContainer(item: items[index]);
      },
    );
  }
}
