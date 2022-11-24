import 'package:dsd/state/auth/providers/auth_state_provider.dart';
import 'package:dsd/state/userinfo/provider/userdetails.dart';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Home extends ConsumerWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userDetails = ref.watch(userDetailsProvider);
    final size = MediaQuery.of(context).size;
    String? avatrString =
        '${userDetails.firstName?.substring(0, 1)}${userDetails.lastName?.substring(0, 1)}';

    return Scaffold(
      backgroundColor: Colors.grey[400],
      body: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.deepPurple,
                  Colors.deepPurple,
                  Colors.deepPurpleAccent
                ]),
              ),
              child: SizedBox(
                width: double.infinity,
                height: size.height * 0.2,
                child: Container(
                  alignment: const Alignment(0.0, 2.5),
                  child: const CircleAvatar(
                    backgroundColor: Colors.deepPurpleAccent,
                    radius: 60.0,
                    child: Text(
                      'RR',
                      style:
                          TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${userDetails.firstName} ${userDetails.lastName}',
                    style: const TextStyle(color: Colors.black, fontSize: 24),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      height: 250,
                      decoration: BoxDecoration(
                          color: Colors.grey[500],
                          border: Border.all(color: Colors.white, width: 5),
                          borderRadius: BorderRadius.circular(50)),
                          child: Column(),
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
                            'Sign Out',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      onTap: () async {
                        final authProvider =
                            ref.read(authStateProvider.notifier);
                        authProvider.logout();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
