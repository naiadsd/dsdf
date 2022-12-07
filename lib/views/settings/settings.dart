import 'package:dsd/db/db_provider.dart';
import 'package:dsd/state/customers/backend/customer_service.dart';
import 'package:dsd/state/customers/model/customer.dart';
import 'package:dsd/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

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
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextButton.icon(
              style: ButtonStyle(),
              onPressed: (() async {
                List<Customer> customers = await fetchCustomersForSave(3, 2);
                await DBProvier.db.storeAllCustomers(customers);
                print('tapped');
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
                List<Customer> customers = await DBProvier.db.getAllCustomers();
                print(customers.length);
              }),
              icon: Icon(Icons.store),
              label: Text('show Customers'),
            ),
          ],
        ),
      ),
    );
  }
}
