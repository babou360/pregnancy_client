import 'package:flutter/rendering.dart';

import 'package:flutter/material.dart';
import 'package:pregnancy_tracking_app/app/sizeConfig.dart';

class pinNumber extends StatelessWidget {
  final TextEditingController textEditingController;
  pinNumber({this.textEditingController});
  double blockWidth = SizeConfig.safeBlockHorizontal;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: blockWidth * 11,
      child: TextField(
        showCursor: false,
        style: TextStyle(
          color: Colors.green[800],
          fontSize: blockWidth * 6,
          fontWeight: FontWeight.w500,
        ),
        controller: textEditingController,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(5.0),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          filled: true,
          fillColor: Colors.green[100],
          border: InputBorder.none,
        ),
      ),
    );
  }
}
