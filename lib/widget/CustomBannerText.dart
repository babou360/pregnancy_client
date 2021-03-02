import 'package:flutter/material.dart';
import 'package:pregnancy_tracking_app/app/sizeConfig.dart';

class CustomBannerText extends StatelessWidget {
  double blockWidth = SizeConfig.safeBlockHorizontal;

  final String title;
  final double size;
  final FontWeight weight;
  final Color color;
  final String fontFamily;
  CustomBannerText({@required this.title, this.size, this.weight, this.color,this.fontFamily});
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: (color == null) ? Colors.green : color,
        fontSize: (size == null) ? blockWidth * 4 : size,
        fontFamily: ( fontFamily == null) ? '' : fontFamily,
        fontWeight: (weight == null) ? FontWeight.w400 : weight,
      ),
      softWrap: true,
    );
  }
}
