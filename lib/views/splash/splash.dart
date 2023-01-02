import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dsd/theme/colors.dart';
import 'package:dsd/views/pages/rootApp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // Timer(
    //   const Duration(seconds: 10),
    //   () => Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) {
    //         return const RootApp();
    //       },
    //     ),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    var images = [1, 2, 3, 4, 5, 6, 7, 8, 9];
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
      ),
      body: Container(
        child: CarouselSlider(
          options: CarouselOptions(
            height: size.height * 0.8,
            viewportFraction: 0.8,
            // // enlargeCenterPage: true,
            enableInfiniteScroll: true,
            autoPlay: true,
            autoPlayInterval: Duration(
              milliseconds: 1,
            ),
            //autoPlayAnimationDuration: const Duration(microseconds: 3),
          ),
          items: images.map((e) {
            return Center(
              child: Image.asset(
                'assets/splashimages/Gelato$e.jpeg',
                fit: BoxFit.fill,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
