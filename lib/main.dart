import 'package:dsd/firebase_options.dart';
import 'package:dsd/models/customer.dart';
import 'package:dsd/models/item.dart';
import 'package:dsd/services/customers.dart';
import 'package:dsd/views/lists/cusotmers.dart';
import 'package:dsd/views/lists/items.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(child: MyApp(),),);
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return MaterialApp(
        title: 'DSD',
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.blueGrey,
          indicatorColor: Colors.blueGrey,
        ),
        theme: ThemeData(
         brightness: Brightness.light,
          primarySwatch: Colors.blue,
        ),
        themeMode: ThemeMode.dark,
        home: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: CustomerList(customerss: fetchCustomers(1, 0),),
        ),);
  }
}

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
