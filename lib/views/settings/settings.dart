import 'package:dsd/db/db_provider.dart';
import 'package:dsd/state/auth/providers/auth_state_provider.dart';
import 'package:dsd/state/customers/backend/customer_service.dart';
import 'package:dsd/state/customers/model/customer.dart';
import 'package:dsd/state/data/data_service.dart';
import 'package:dsd/state/items/backend/item_service.dart';
import 'package:dsd/state/items/models/item.dart';
import 'package:dsd/state/routeday/provider/routeday.dart';
import 'package:dsd/state/userinfo/provider/userdetails.dart';
import 'package:dsd/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: AppBar(
          actions: [],
          elevation: 0,
          title: Text(
            'Settings',
            style: TextStyle(color: secondary),
          ),
          backgroundColor: Colors.transparent,
        ),
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    return HookConsumer(builder: (context, ref, child) {
      return Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextButton.icon(
                style: ButtonStyle(),
                onPressed: (() async {
                  List<Customer> customers = await fetchCustomersForSave(3, 2);
                  await DBProvier.db.storeAllCustomers(customers);
                }),
                icon: Icon(Icons.store),
                label: Text('Store Customers'),
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton.icon(
                style: ButtonStyle(),
                onPressed: (() async {
                  List<Customer> customers =
                      await DBProvier.db.getAllCustomers();

                  await DBProvier.db.dropPromotable();
                  // print(customers.length);
                }),
                icon: Icon(Icons.store),
                label: Text('show Customers'),
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton.icon(
                style: ButtonStyle(),
                onPressed: (() async {
                  List<Item> items = await fetchItemsSave();
                  await DBProvier.db.storeAllItems(items);
                }),
                icon: Icon(Icons.store),
                label: Text('Store Items'),
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton.icon(
                style: ButtonStyle(),
                onPressed: (() async {
                  List<Item> customers = await DBProvier.db.getAllItems();
                }),
                icon: Icon(Icons.store),
                label: Text('show Items'),
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton.icon(
                style: ButtonStyle(),
                onPressed: (() async {
                  int routeday = await ref.watch(routeDayProvider);
                  int? day = ref.watch(userDetailsProvider).route;
                  print('$day and $routeday');
                  fetchStoreDailyData(routeday, day ?? 1)
                      .then((value) => print(value))
                      .catchError((e) => print(e));
                }),
                icon: Icon(Icons.store),
                label: Text('Fetch All  Items'),
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton.icon(
                style: ButtonStyle(),
                onPressed: (() async {
                  var authProvider = ref.watch(authStateProvider.notifier);
                  await authProvider.logout();
                }),
                icon: Icon(Icons.store),
                label: Text('Log out'),
              ),
            ],
          ),
        ),
      );
    });
  }
}
