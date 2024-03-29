import 'package:dsd/firebase_options.dart';
import 'package:dsd/state/auth/providers/auth_state_provider.dart';
import 'package:dsd/state/auth/providers/is_logged_in_provider.dart';
import 'package:dsd/state/auth/providers/user_id_provider.dart';
import 'package:dsd/state/connectivity/connectivity_notifier.dart';
import 'package:dsd/state/connectivity/connectivity_provider.dart';
import 'package:dsd/state/search/loading.dart';
import 'package:dsd/state/userinfo/provider/userdetails.dart';
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

class SplashDisplay extends ConsumerWidget {
  forceLogout(WidgetRef ref) {
    var l = ref.read(userDetailsProvider);
    if (l.email == null) ref.read(authStateProvider.notifier).logout();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build
    return Consumer(
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
        ref.listen<ConnectivityStatus>(connectivityStatusProviders, (_, next) {
          if (next != ConnectivityStatus.isConnected) {
            ref.watch(isloadingProvider.notifier).turnOnLoading();
            LoadingScreen.instance()
                .show(text: 'No Internet connection', context: context);
          } else {
            LoadingScreen.instance().hide();
          }
        });
        bool isAuthenticate = ref.watch(isLoggedInProvider);

        if (isAuthenticate) {
          //forceLogout(ref);
          return RootApp(
            startIndex: 0,
          );
        } else {
          return const Login();
        }
      },
    );
  }
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

      home: const Splash(),

      /*  Consumer(
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
            return const RootApp();
          } else {
            return const Login();
          }
        },
      ),*/
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