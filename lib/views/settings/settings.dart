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
import 'package:intl/intl.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    GlobalKey scsett = GlobalKey();
    return Scaffold(
      key: scsett,
      backgroundColor: background,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: AppBar(
          actions: [],
          elevation: 0,
          title: const Text(
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
                  List<Customer> customers = await fetchAllCustomers();
                  print(customers.length);
                  await DBProvier.db.storeAllCustomers(customers);
                }),
                icon: Icon(Icons.store),
                label: Text('Store asda'),
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton.icon(
                style: const ButtonStyle(),
                onPressed: (() {
                  var day = DateTime.now().weekday;
                  print('Day is $day');
                }),
                icon: const Icon(Icons.store),
                label: const Text('show Customers'),
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton.icon(
                style: const ButtonStyle(),
                onPressed: (() async {
                  List<Item> items = await fetchItemsSave();
                  await DBProvier.db.storeAllItems(items);
                }),
                icon: const Icon(Icons.store),
                label: const Text('Store Items'),
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton.icon(
                style: ButtonStyle(),
                onPressed: (() async {
                  List<Item> customers = await DBProvier.db.getAllItems();
                }),
                icon: const Icon(Icons.store),
                label: const Text('show Items'),
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton.icon(
                style: const ButtonStyle(),
                onPressed: (() async {
                  int routeday = await ref.watch(routeDayProvider);
                  int? day = ref.watch(userDetailsProvider).route;

                  await fetchAndStoreCustomers(routeday, day ?? 1);
                }),
                icon: const Icon(Icons.store),
                label: const Text('Fetch All  Items'),
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton.icon(
                style: const ButtonStyle(),
                onPressed: (() async {
                  var authProvider = ref.watch(authStateProvider.notifier);
                  await authProvider.logout();
                }),
                icon: const Icon(Icons.store),
                label: const Text('Log out'),
              ),
            ],
          ),
        ),
      );
    });
  }
}
