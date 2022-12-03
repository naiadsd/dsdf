import 'package:flutter/material.dart';

class ItemClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(0, size.height / 2);
    //path.lineTo(size.height * 0.4, size.height * 0.4);
    path.quadraticBezierTo(size.width / 2, 0, size.width, size.height / 2);
    path.quadraticBezierTo(0, 0, 0, 0);
    //path.lineTo(size.width, 0);
    // path.lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
