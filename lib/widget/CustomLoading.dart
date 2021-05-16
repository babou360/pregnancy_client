import 'package:flutter/material.dart';
import 'package:pregnancy_tracking_app/app/sizeConfig.dart';

// ignore: must_be_immutable
class CustomLoading extends StatelessWidget {
  double blockHeight = SizeConfig.safeBlockVertical;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
    // return Container(
    //   child: Column(
    //     children: <Widget>[
    //       SizedBox(height: blockHeight * 20),
    //       Container(
    //         child: Center(
    //           child: CircularProgressIndicator(),
    //         ),
    //       )
    //     ],
    //   ),
    // );
  }
}
