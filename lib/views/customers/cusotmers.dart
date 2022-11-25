import 'package:dsd/models/customer.dart';
import 'package:dsd/models/item.dart';
import 'package:dsd/views/customers/customer.dart';

import 'package:flutter/material.dart';

class Customers extends StatelessWidget {
  final List<Customer> customers;
  const Customers({Key? key, required this.customers}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: customers.length,
      itemBuilder: (context, index) {
        return CustomerContainer(customer: customers[index]);
      },
    );
  }
}
