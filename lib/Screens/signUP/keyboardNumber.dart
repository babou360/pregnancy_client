import 'package:flutter/material.dart';
import 'package:pregnancy_tracking_app/app/sizeConfig.dart';

class keyboardNumber extends StatelessWidget {
  double blockHeight = SizeConfig.safeBlockVertical;
  double blockWidth = SizeConfig.safeBlockHorizontal;
  final int number;
  final Function() onKeyPressed;

  keyboardNumber({this.number, this.onKeyPressed});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: blockWidth * 15,
      width: blockWidth * 15,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.green[300].withOpacity(0.8),
      ),
      child: MaterialButton(
        splashColor: Colors.green[700],
        padding: EdgeInsets.all(5.0),
        onPressed: onKeyPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: Text(
          "$number",
          style: TextStyle(
            fontSize: blockWidth * 7.5,
            color: Colors.white,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }
}
