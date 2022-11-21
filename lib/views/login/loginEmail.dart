import 'package:flutter/material.dart';

class LoginEmail extends StatelessWidget {
  const LoginEmail({
    Key? key,
    required this.emailController,
  }) : super(key: key);

  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      child: TextField(
        controller: emailController,
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Email',
            labelStyle:
                TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
