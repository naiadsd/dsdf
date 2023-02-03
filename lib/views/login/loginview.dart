import 'package:dsd/views/login/loginEmail.dart';
import 'package:dsd/views/login/login_password.dart';
import 'package:dsd/views/login/submitbutton.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginView({Key? key}) : super(key: key);
  GlobalKey scaffoldkodf = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkodf,
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LoginEmail(emailController: _emailController),
            const SizedBox(height: 30.0),
            LoginPassword(passwordController: _passwordController),
            const SizedBox(height: 30.0),
            SubmitButton(
              email: _emailController.text,
              password: _passwordController.text,
            ),
            const SizedBox(height: 30.0),
          ],
        ),
      ),
    );
  }
}
