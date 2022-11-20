import 'package:dsd/state/auth/models/auth_results.dart';
import 'package:dsd/state/auth/providers/auth_state_provider.dart';
import 'package:dsd/views/login/google_button.dart';
import 'package:dsd/views/login/loginEmail.dart';
import 'package:dsd/views/login/login_password.dart';

import 'package:dsd/state/auth/providers/user_id_provider.dart';
import 'package:dsd/state/userinfo/provider/userdetails.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginView extends ConsumerWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('DSD'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              Text(
                'Welcome to DSD',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              LoginEmail(emailController: emailController),
              const SizedBox(height: 30.0),
              LoginPassword(passwordController: passwordController),
              const SizedBox(height: 30.0),
              const SizedBox(height: 30.0),
              ElevatedButton(
                  onPressed: () async {
                    try {
                      final authService = ref.read(authStateProvider.notifier);
                      final result = await authService.loginWithEmailPassword(
                          emailController.text, passwordController.text);
                      final userService =
                          ref.read(userDetailsProvider.notifier);
                      if (result == AuthResult.success) {
                        final userId = ref.read(userIdProvider);
                        print('userID $userId');
                        userService.fetchUserDetails(userId);
                        //  Navigator.of(context).pushReplacement(
                        //      MaterialPageRoute(builder: (context) => const Home()));
                      }
                      // await _authService.signInWithEmailAndPassword(
                      //   email: email,
                      //   password: password,
                      // );
                      // Navigator.of(context)
                      //     .pushReplacement(MaterialPageRoute(builder: (context) => Home()));
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(e.toString()),
                        ),
                      );
                    }
                  },
                  child: const Text('Login')),
              GestureDetector(
                child: const GoogleButton(),
                onTap: () {
                  final authProvider = ref.read(authStateProvider.notifier);
                  authProvider.loginWithGoogle();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
