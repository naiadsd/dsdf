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
                height: 44.0,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white38,
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
                              color: Colors.blue,
                              fontFamily: 'Open Sans',
                              decoration: TextDecoration.none),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: ((context) {
                                return const RootApp();
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
