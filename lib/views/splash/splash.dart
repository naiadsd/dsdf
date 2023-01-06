import 'dart:async';
import 'dart:ui';

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
  get e => null;

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
    var images = [
      'https://firebasestorage.googleapis.com/v0/b/gelaterianaia-a3f12.appspot.com/o/Gelato1.jpeg?alt=media&token=3ac21c73-5a83-4801-8e0a-08d7abb4880f',
      'https://firebasestorage.googleapis.com/v0/b/gelaterianaia-a3f12.appspot.com/o/Gelato2.jpeg?alt=media&token=e88ab7b3-8b69-4e0f-90b7-cc45ff1ef4a7',
      'https://firebasestorage.googleapis.com/v0/b/gelaterianaia-a3f12.appspot.com/o/Gelato3.jpeg?alt=media&token=d16ac01c-4a0d-482f-965a-7961da518e5c',
      'https://firebasestorage.googleapis.com/v0/b/gelaterianaia-a3f12.appspot.com/o/Gelato4.jpeg?alt=media&token=64f9f40b-ee7b-4af4-a815-f23d9d61b65d',
      'https://firebasestorage.googleapis.com/v0/b/gelaterianaia-a3f12.appspot.com/o/Gelato5.jpeg?alt=media&token=ac65b4e1-6e4a-44fb-a2df-c10c98d957b5',
      'https://firebasestorage.googleapis.com/v0/b/gelaterianaia-a3f12.appspot.com/o/Gelato6.jpeg?alt=media&token=95bf2b6a-e64e-4810-8fc7-d22ae8607445',
      'https://firebasestorage.googleapis.com/v0/b/gelaterianaia-a3f12.appspot.com/o/Gelato7.jpeg?alt=media&token=66f18020-c82d-470d-bd04-819cf6a114fa',
      'https://firebasestorage.googleapis.com/v0/b/gelaterianaia-a3f12.appspot.com/o/Gelato8.jpeg?alt=media&token=afa6af50-590e-4c5c-83c7-c1fac862a675',
    ];
    Size size = MediaQuery.of(context).size;

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(images[0]),
              fit: BoxFit.cover,
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 15,
              sigmaY: 15,
            ),
            child: Container(color: Colors.black.withOpacity(0.2)),
          ),
        ),
        FractionallySizedBox(
          heightFactor: 0.8,
          child: PageView.builder(
            itemBuilder: ((context, index) {
              return FractionallySizedBox(
                widthFactor: 0.8,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    image: DecorationImage(
                      image: NetworkImage(images[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            }),
            itemCount: images.length,
          ),
        ),
      ],
    );
  }
}
/*return Scaffold(
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
    );*/