import 'package:dsd/state/items/models/item.dart';
import 'package:flutter/material.dart';

class ItemContainer extends StatelessWidget {
  final Item item;

  const ItemContainer({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(2),
        height: 140,
        child: Card(
          elevation: 5,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                    child: Container(
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(item.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            Text("id:${item.id}"),
                            Text("quantity:${item.reOrderQuantity}"),
                          ],
                        )))
              ]),
        ));
  }
}
