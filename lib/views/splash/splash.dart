import 'package:dsd/main.dart';
import 'package:dsd/theme/colors.dart';
import 'package:dsd/views/pages/rootApp.dart';
import 'package:dsd/views/splash/splashImages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.grey.shade400),
      child: Column(
        children: [
          const SplashScreen(),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: SizedBox(
                height: 64.0,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                      color: secondary,
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextButton(
                        child: const Text(
                          'Let' 's, start',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontFamily: 'Open Sans',
                              decoration: TextDecoration.none),
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: ((context) {
                                return SplashDisplay();
                              }),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      FaIcon(FontAwesomeIcons.arrowRight, color: Colors.blue),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
