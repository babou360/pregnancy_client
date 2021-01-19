import 'package:flutter/material.dart';
import 'package:pregnancy_tracking_app/app/sizeConfig.dart';

class CustomBannerText extends StatelessWidget {
  double blockWidth = SizeConfig.safeBlockHorizontal;

  final String title;
  final double size;
  final FontWeight weight;
  final Color color;
  CustomBannerText({@required this.title, this.size, this.weight, this.color});
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: (color == null) ? Colors.black54 : color,
        fontSize: (size == null) ? blockWidth * 4 : size,
        fontWeight: (weight == null) ? FontWeight.w300 : weight,
      ),
      softWrap: true,
    );
  }
}
