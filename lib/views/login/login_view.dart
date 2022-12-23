import 'package:dsd/state/auth/models/auth_results.dart';
import 'package:dsd/state/auth/providers/auth_state_provider.dart';
import 'package:dsd/views/login/google_button.dart';
import 'package:dsd/views/login/loginEmail.dart';
import 'package:dsd/views/login/login_password.dart';

import 'package:dsd/state/auth/providers/user_id_provider.dart';
import 'package:dsd/state/userinfo/provider/userdetails.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginView extends ConsumerWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.transparent,
              ),
              // child: Image.asset(
              //   'assets/images/invoice_logo.png',
              // ),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Email',
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Password',
                    ),
                  ),
                ),
              ),
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
                  final authProvider = ref.read(authStateProvider.notifier);
                  await authProvider
                      .loginWithEmailPassword(
                          emailController.text, passwordController.text)
                      .then((value) {})
                      .catchError((e) {});

                  final userID = ref.read(userIdProvider);
                  final userDetailsPRovider =
                      ref.read(userDetailsProvider.notifier);
                  userDetailsPRovider.fetchUserDetails(userID);
                },
              ),
            ),
            const Center(child: Text('Or')),
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
          ],
        ),
      ),
    );
  }
}
