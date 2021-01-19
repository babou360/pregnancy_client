import 'package:flutter/material.dart';

class SliderControl extends StatelessWidget {
  final String description;
  final String imagePath;

  SliderControl({this.description, this.imagePath});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Image.asset(
              imagePath,
              width: width * 0.7,
              filterQuality: FilterQuality.low,
            ),
          ),
          SizedBox(height: 40.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 60.0),
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.teal[900],
                height: 1.5,
                fontSize: 18.0,
                fontWeight: FontWeight.normal,
                letterSpacing: 0.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
