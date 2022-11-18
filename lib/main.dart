import 'package:dsd/models/customer.dart';
import 'package:dsd/models/item.dart';
import 'package:dsd/services/customers.dart';
import 'package:dsd/views/lists/cusotmers.dart';
import 'package:dsd/views/lists/items.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
         
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',

        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: CustomerList(customerss: fetchCustomers(1, 0)),
        ));
  }
}

class ItemList extends StatelessWidget {
  final Future<List<Item>> items;
  const ItemList({required this.items});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      s
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

class CustomerList extends StatelessWidget {
  final Future<List<Customer>> customerss;
  const CustomerList({required this.customerss});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Customers"),
          backgroundColor: Colors.cyan,
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
