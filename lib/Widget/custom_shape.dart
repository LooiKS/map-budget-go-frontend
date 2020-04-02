import 'package:flutter/material.dart';

class CustomShapeBorder extends ContinuousRectangleBorder {
  @override
  Path getOuterPath(Rect size, {TextDirection textDirection}) {
    Path path = Path();
    path.lineTo(0, size.height + 15);
    path.quadraticBezierTo(
        size.width / 4, size.height - 15, size.width / 2, size.height);
    path.quadraticBezierTo(
        3 / 4 * size.width, size.height + 20, size.width, size.height + 10);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }
}
