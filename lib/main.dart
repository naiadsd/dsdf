import 'package:dsd/firebase_options.dart';
import 'package:dsd/state/auth/providers/is_logged_in_provider.dart';
import 'package:dsd/state/search/loading.dart';
import 'package:dsd/views/components/loading/loading_screen.dart';
import 'package:dsd/views/login/login.dart';

import 'package:dsd/views/pages/rootApp.dart';
import 'package:dsd/views/splash/splash.dart';
import 'package:dsd/views/splash/splashImages.dart';

import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';

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
    //  final internet = InternetConnectionChecker();
    return MaterialApp(
      // title: 'DSD',
      darkTheme: ThemeData(
        // fontFamily: 'WorkSans',ios
        fontFamily: 'Open Sans, sans-serif', //andrioid
        brightness: Brightness.dark,
        primarySwatch: Colors.blueGrey,
        indicatorColor: Colors.blueGrey,
      ),
      theme: ThemeData(
        // fontFamily: 'WorkSans',
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,

      home: Consumer(
        builder: (context, ref, child) {
          ref.listen<bool>(
            isloadingProvider,
            (_, isLoading) {
              if (isLoading) {
                LoadingScreen.instance().show(
                  context: context,
                );
              } else {
                LoadingScreen.instance().hide();
              }
            },
          );
          bool isAuthenticate = ref.watch(isLoggedInProvider);

          if (isAuthenticate) {
            return const Splash();
          } else {
            return const Login();
          }
        },
      ),
    );
  }
}

    //: Center(
      //  child: Text('no internet connection...'),
      //),
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