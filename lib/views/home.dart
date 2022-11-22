import 'package:dsd/state/auth/providers/auth_state_provider.dart';
import 'package:dsd/state/userinfo/provider/userdetails.dart';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Home extends ConsumerWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userDetails = ref.watch(userDetailsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
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
                'Welcome to DSD ${userDetails.firstName}',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              GestureDetector(
                child: const Text('Logout'),
                onTap: () {
                  final authProvider = ref.read(authStateProvider.notifier);
                  authProvider.logout();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
