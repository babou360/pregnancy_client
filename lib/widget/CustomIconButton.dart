import 'package:flutter/material.dart';
import 'package:pregnancy_tracking_app/app/sizeConfig.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback callback;
  CustomIconButton({@required this.icon, @required this.callback});
  double blockWidth = SizeConfig.safeBlockHorizontal;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(blockWidth * 2),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: InkWell(
        child: Icon(
          icon,
          color: Colors.white,
          size: blockWidth * 5,
        ),
        onTap: () {
          callback();
        },
      ),
    );
  }
}
