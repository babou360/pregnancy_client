import 'package:flutter/material.dart';
import 'package:pregnancy_tracking_app/app/sizeConfig.dart';

class CustomTitle extends StatelessWidget {
  CustomTitle({
    @required this.title,
    this.left,
    this.right,
    this.top,
    this.bottom,
  });
  double left, right, top, bottom, fontSize;
  String title;

  @override
  Widget build(BuildContext context) {
    double blockWidth = SizeConfig.safeBlockHorizontal;
    return Positioned(
      top: (top != null) ? top : null,
      bottom: (bottom != null) ? bottom : null,
      right: (right != null) ? right : null,
      left: (left != null) ? left : null,
      child: Text(
        title,
        style: TextStyle(
          color: Colors.grey[800],
          fontFamily: 'Noto',
          fontSize: blockWidth * 8,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
