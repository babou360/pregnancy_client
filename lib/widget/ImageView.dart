import 'package:flutter/material.dart';
import 'package:pregnancy_tracking_app/app/sizeConfig.dart';

class ImageView extends StatelessWidget {
  double blockWidth = SizeConfig.safeBlockHorizontal;
  double blockHeight = SizeConfig.safeBlockVertical;

  final String imageURL;
  final double height;
  final EdgeInsetsGeometry margin;
  ImageView({@required this.imageURL, this.height, this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: (margin == null)
          ? EdgeInsets.symmetric(horizontal: blockWidth * 3)
          : margin,
      height: (height == null) ? blockHeight * 30 : height,
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 3,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
        image: DecorationImage(
          image: NetworkImage(imageURL),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
    );
  }
}
