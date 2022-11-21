import 'package:dsd/views/login/loginEmail.dart';
import 'package:dsd/views/login/login_password.dart';
import 'package:dsd/views/widgets/dsdinputfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Sign extends StatefulWidget {
  const Sign({Key? key}) : super(key: key);

  @override
  State<Sign> createState() => _SignState();
}

class _SignState extends State<Sign> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();

    final TextEditingController passwordController = TextEditingController();
    final size = MediaQuery.of(context).size;
    String email;
    bool visiblePassword = false;
    String password;
    return Container(
      width: size.width,
      height: size.height,
      padding: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 200,
            ),
            const Text(
              'Sign in to DSD',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Enter your details below',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: 300,
              child: DSDInputText(
                  onChanged: (val) {
                    setState(() {
                      email = val.toString();
                    });
                  },
                  hintText: 'Email'),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: 300,
              child: DSDInputText(
                obscureText: !visiblePassword,
                hintText: 'Enter Password',
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.visiblePassword,
                onChanged: (val) {
                  setState(() {
                    password = val.toString();
                  });
                },
                validator: (password) {
                  if (password == null || password.isEmpty) {
                    return "Empty password";
                  }
                  return null;
                },
                suffixIcon: InkWell(
                  onTap: () {
                    setState(() {
                      visiblePassword = !visiblePassword;
                    });
                  },
                  child: Icon(
                    visiblePassword ? Icons.visibility_off : Icons.visibility,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
