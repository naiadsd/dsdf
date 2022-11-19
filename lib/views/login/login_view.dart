import 'package:dsd/state/auth/providers/auth_state_provider.dart';
import 'package:dsd/views/login/google_button.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginView extends ConsumerWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
