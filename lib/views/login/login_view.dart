import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginView extends ConsumerWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('DSD'),),
      body: Padding(padding: const EdgeInsets.all(16.0),child: SingleChildScrollView(child:Column(
        children: [
           const SizedBox(
                height: 40,
              ),
                Text(
                'Welcome to DSD',
                style: Theme.of(context).textTheme.displaySmall,
              ),
        ],
      ),),),
    );
  }
}