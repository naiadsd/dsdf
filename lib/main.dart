import 'package:dsd/firebase_options.dart';
import 'package:dsd/state/auth/providers/is_logged_in_provider.dart';

import 'package:dsd/views/home.dart';
import 'package:dsd/views/items/items.dart';

import 'package:dsd/views/login/login_view.dart';
import 'package:dsd/views/orders/orders.dart';
import 'package:dsd/views/pages/rootApp.dart';

import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(
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
        fontFamily: 'WorkSans',
        brightness: Brightness.dark,
        primarySwatch: Colors.blueGrey,
        indicatorColor: Colors.blueGrey,
      ),
      theme: ThemeData(
        fontFamily: 'WorkSans',
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,

      home: RootApp(),
      //routerConfig: _router,
      // home: Scaffold(
      //   body: Consumer(builder: ((context, ref, child) {
      //     final isloggedin = ref.watch(isLoggedInProvider);
      //     //final authProvider = ref.read(authStateProvider.notifier);

      //     if (isloggedin) {
      //       return const Home();
      //     } else {
      //       return const LoginView();
      //     }
      //   })),
      // ),
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

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, state) {
        return Consumer(builder: ((context, ref, child) {
          final isloggedin = ref.watch(isLoggedInProvider);
          //final authProvider = ref.read(authStateProvider.notifier);

          if (isloggedin) {
            return const Home();
          } else {
            return const LoginView();
          }
        }));
      },
    ),
    GoRoute(
      path: '/customers',
      builder: ((context, state) => const Text('sd')),
    ),
    GoRoute(
      path: '/items',
      builder: ((context, state) => const Text('Hello items')),
    ),
    GoRoute(
      path: '/orders',
      builder: (context, state) {
        return const Orders();
      },
    ),
  ],
);
