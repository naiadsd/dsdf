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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/background.jpeg'),
                      fit: BoxFit.cover)),
              child: SizedBox(
                width: double.infinity,
                height: 200,
                child: Container(
                  alignment: const Alignment(0.0, 2.5),
                  child: const CircleAvatar(
                    child: Text('R'),
                    radius: 60.0,
                  ),
                ),
              ),
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
    );
  }
}
