import 'package:flutter/material.dart';

Widget noInternetConnectionFound() {
  return Stack(
    fit: StackFit.expand,
    children: [
      Image.asset(
        "assets/images/1_No Connection.png",
        fit: BoxFit.cover,
      ),
      Positioned(
        bottom: 100,
        left: 30,
        child: TextButton(
          // color: Colors.white,
          //shape:
          //  RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          onPressed: () {},
          child: Text("Retry".toUpperCase()),
        ),
      )
    ],
  );
}
