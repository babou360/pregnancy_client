import 'package:flutter/material.dart';

class CustomDesignUI extends StatelessWidget {
  double left, right, top, bottom, height;
  String imagePath;
  Color color;
  CustomDesignUI({
    @required this.imagePath,
    @required this.color,
    @required this.height,
    this.top,
    this.bottom,
    this.left,
    this.right,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      height: height,
      top: (top != null) ? top : null,
      bottom: (bottom != null) ? bottom : null,
      left: (left != null) ? left : null,
      right: (right != null) ? right : null,
      child: Image.asset(
        imagePath,
        color: color,
      ),
    );
  }
}
