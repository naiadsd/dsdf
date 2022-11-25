import 'package:dsd/models/customer.dart';
import 'package:dsd/models/item.dart';
import 'package:flutter/material.dart';

class CustomerContainer extends StatelessWidget {
  final Customer customer;

  const CustomerContainer({Key? key, required this.customer}) : super(key: key);

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
                            Text(customer.customerName,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            Text("id:${customer.serviceDays}"),
                            Text("quantity:${customer.creditLimit}"),
                          ],
                        )))
              ]),
        ));
  }
}
