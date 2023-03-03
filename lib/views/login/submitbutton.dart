import 'package:dsd/state/auth/models/auth_results.dart';
import 'package:dsd/state/auth/providers/auth_state_provider.dart';
import 'package:dsd/state/auth/providers/user_id_provider.dart';
import 'package:dsd/state/userinfo/provider/userdetails.dart';
import 'package:dsd/views/home.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SubmitButton extends ConsumerWidget {
  const SubmitButton({
    Key? key,
    required this.email,
    required this.password,
  }) : super(key: key);

  final String email, password;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () async {
        try {
          final authService = ref.read(authStateProvider.notifier);
          final result =
              await authService.loginWithEmailPassword(email, password);
          final userService = ref.read(userDetailsProvider.notifier);
          if (result == AuthResult.success) {
            final userId = ref.read(userIdProvider);

            userService.fetchUserDetails(userId, ref);
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.toString()),
            ),
          );
        }
      },
      child: const Text('Login'),
    );
  }
}
