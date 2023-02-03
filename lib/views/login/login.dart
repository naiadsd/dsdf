import 'package:dsd/state/auth/models/auth_results.dart';
import 'package:dsd/state/auth/providers/auth_state_provider.dart';
import 'package:dsd/state/auth/providers/is_logged_in_provider.dart';
import 'package:dsd/state/auth/providers/user_id_provider.dart';
import 'package:dsd/state/customers/backend/customer_service.dart';
import 'package:dsd/state/data/data_service.dart';
import 'package:dsd/state/routeday/provider/routeday.dart';
import 'package:dsd/state/search/loading.dart';
import 'package:dsd/state/userinfo/provider/userdetails.dart';
import 'package:dsd/views/components/loading/loading_screen.dart';
import 'package:dsd/views/login/components/custom_form_field.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isValidEmail(val) {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(val);
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    final formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Consumer(builder: ((context, ref, child) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.transparent,
                  ),
                  child: Image.asset(
                    'assets/images/logo.png',
                    color: Colors.transparent,
                  ),
                ),
                Text(
                  'Hello Again..',
                  style: GoogleFonts.bebasNeue(
                    fontSize: 40,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'welcome back to DSD',
                  style: GoogleFonts.bebasNeue(
                    fontSize: 30,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      CustomFormField(
                        hintText: 'Email',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter email';
                          }
                          if (!isValidEmail(value)) {
                            return 'Invalid email.';
                          }
                          setState(() {
                            emailController.text = value;
                          });
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomFormField(
                        hintText: 'Password',
                        isObScure: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter password.';
                          }
                          setState(() {
                            passwordController.text = value;
                          });
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: GestureDetector(
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.deepPurple,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text(
                                'Sign In',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              ref
                                  .read(isloadingProvider.notifier)
                                  .turnOnLoading();
                              LoadingScreen.instance().show(
                                  context: context, text: 'loggin you in');
                              final authProvider =
                                  ref.read(authStateProvider.notifier);
                              await authProvider
                                  .loginWithEmailPassword(emailController.text,
                                      passwordController.text)
                                  .then((value) async {
                                if (value == AuthResult.success) {
                                  final userID = ref.read(userIdProvider);
                                  final userDetailsPRovider =
                                      ref.read(userDetailsProvider.notifier);
                                  await userDetailsPRovider
                                      .fetchUserDetails(userID);
                                  final userDetails =
                                      ref.read(userDetailsProvider);
                                  final routeDay = ref.read(routeDayProvider);
                                  await fetchAndStoreCustomers(
                                      userDetails.route, routeDay);

                                  ref
                                      .read(isloadingProvider.notifier)
                                      .turnOffLoading();
                                } else {
                                  ref
                                      .read(isloadingProvider.notifier)
                                      .turnOffLoading();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Container(
                                        constraints: const BoxConstraints(
                                          maxHeight: 200,
                                          minHeight: 80.0,
                                        ),
                                        child: const Center(
                                          child: Text(
                                            'Invalid credentials...',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              }).catchError((e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Error occured,Please contact admin.',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                );
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        })),
      ),
    );
  }

  AlertDialog alert = AlertDialog(
    title: const Text('logging in..'),
    content: const Padding(
      padding: EdgeInsets.all(8.0),
      child: Text("Do you want to order for this customer?.."),
    ),
    actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
      ),
    ],
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.0))),
    contentPadding: const EdgeInsets.all(10),
    elevation: 30,
  );
}

// ignore: camel_case_extensions
extension extString on String {
  bool get isValidEmail {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(this);
  }

  bool get isValidName {
    final nameRegExp =
        RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
    return nameRegExp.hasMatch(this);
  }

  bool get isValidPassword {
    final passwordRegExp = RegExp(
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\><*~]).{8,}/pre>');
    return passwordRegExp.hasMatch(this);
  }

  bool get isNotNull {
    // ignore: unnecessary_null_comparison
    return this != null;
  }

  bool get isValidPhone {
    final phoneRegExp = RegExp(r"^\+?0[0-9]{10}$");
    return phoneRegExp.hasMatch(this);
  }
}


/*

Padding(
                padding: const EdgeInsets.all(25.0),
                child: GestureDetector(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        FaIcon(FontAwesomeIcons.google, color: Colors.white),
                        SizedBox(
                          width: 15,
                        ),
                        Center(
                          child: Text(
                            'Sign In with Google',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () async {
                    final authProvider = ref.read(authStateProvider.notifier);
                    await authProvider.loginWithGoogle();

                    final userID = ref.read(userIdProvider);
                    final userDetailsPRovider =
                        ref.read(userDetailsProvider.notifier);
                    userDetailsPRovider.fetchUserDetails(userID);
                  },
                ),
              ),

              */