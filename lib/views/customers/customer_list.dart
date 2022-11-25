import 'package:dsd/models/customer.dart';
import 'package:dsd/views/customers/cusotmers.dart';
import 'package:flutter/material.dart';

class CustomerList extends StatelessWidget {
  final Future<List<Customer>> customerss;
  const CustomerList({required this.customerss});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Customers"),
          backgroundColor: Color.fromARGB(255, 159, 0, 212),
          centerTitle: true,
        ),
        body: Center(
          child: FutureBuilder<List<Customer>>(
            future: customerss,
            builder: (context, snapshot) {
              if (snapshot.hasError) {}
              return snapshot.hasData
                  ? Customers(customers: snapshot.data ?? [])
                  : const Center(child: CircularProgressIndicator());
            },
          ),
        ));
  }
}
