import 'package:dsd/firebase_options.dart';
import 'package:dsd/models/customer.dart';
import 'package:dsd/models/item.dart';
import 'package:dsd/state/auth/backend/authenticator.dart';
import 'package:dsd/state/auth/providers/auth_state_provider.dart';
import 'package:dsd/state/auth/providers/is_logged_in_provider.dart';
import 'package:dsd/views/home.dart';
import 'package:dsd/views/lists/cusotmers.dart';
import 'package:dsd/views/lists/items.dart';
import 'package:dsd/views/login/login.dart';
import 'package:dsd/views/login/login_view.dart';
import 'package:dsd/views/login/signin.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ProviderScope(
    child: App(),
  ));
}

class App extends ConsumerWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      // title: 'DSD',
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blueGrey,
        indicatorColor: Colors.blueGrey,
      ),
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Consumer(builder: ((context, ref, child) {
          final isloggedin = ref.watch(isLoggedInProvider);
          //final authProvider = ref.read(authStateProvider.notifier);

          if (isloggedin) {
            return const Home();
          } else {
            return const Login();
          }
        })),
      ),
    );
  }
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'DSD',
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blueGrey,
        indicatorColor: Colors.blueGrey,
      ),
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.purple,
      ),
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,

      home: Consumer(builder: (
        context,
        ref,
        child,
      ) {
        final isLogged = ref.watch(isLoggedInProvider);
        if (isLogged) {
          return const Text('logged in');
        } else {
          return const Text('not logged in');
          //  return const LoginView();
        }
      }),
      //home: CustomerList(customerss: fetchCustomers(1, 0),),
    );
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
