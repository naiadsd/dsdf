import 'package:dsd/state/auth/providers/auth_state_provider.dart';
import 'package:dsd/views/login/google_button.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Login extends ConsumerWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 150,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text(
                    'Login',
                    style: TextStyle(fontSize: 34, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.stars,
                    color: Colors.amber,
                    size: 30,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Welcome back....!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
              ),
              const SizedBox(
                height: 35,
              ),
              DSInput(emailController, 'username or email'),
              const SizedBox(
                height: 20,
              ),
              DSInput(passwordController, 'Password'),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: size.width,
                height: 70,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20)),
                child: const Text(
                  'Login',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.center,
                height: 30,
                margin: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                child: const Text('or continue with '),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.center,
                height: 70,
                margin: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                decoration: BoxDecoration(
                    border: Border.all(
                      style: BorderStyle.solid,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(30)),
                child: GestureDetector(
                  child: const GoogleButton(),
                  onTap: () {
                    print('tappd');
                    final authProvider = ref.read(authStateProvider.notifier);
                    authProvider.loginWithGoogle();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget DSInput(TextEditingController emailController, String hint) {
    return TextField(
      obscureText: false,
      textAlign: TextAlign.start,
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),
      controller: emailController,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
        hintText: hint,
        //   fillColor: Theme.of(context).backgroundColor,
        filled: true,
        errorStyle: const TextStyle(height: 0, color: Colors.transparent),
        hintStyle: const TextStyle(
          fontSize: 20,
          color: Color(0xFF969A9D),
          fontWeight: FontWeight.w300,
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF707070), width: 0)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF707070), width: 0)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF707070), width: 0)),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
        ),
      ),
    );
  }
}
