import 'package:flutter/material.dart';
import 'package:pregnancy_tracking_app/Screens/profile/profileScreen.dart';
import 'package:pregnancy_tracking_app/app/sizeConfig.dart';
import 'package:pregnancy_tracking_app/models/user.dart';

class UnPaiedScreen extends StatefulWidget {
  User1 currentUser;
  UnPaiedScreen(this.currentUser);
  @override
  _UnPaiedScreenState createState() => _UnPaiedScreenState();
}

class _UnPaiedScreenState extends State<UnPaiedScreen> {
  double blockHeight = SizeConfig.safeBlockVertical;
  double blockWidth = SizeConfig.safeBlockHorizontal;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: blockWidth * 2, vertical: blockHeight * 1),
                  width: double.infinity,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: blockWidth * 5, vertical: blockHeight * 3),
                    decoration: BoxDecoration(
                      color: Colors.redAccent[200].withOpacity(0.8),
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "POLE !! ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: blockWidth * 10,
                              fontWeight: FontWeight.w900),
                        ),
                        SizedBox(height: blockHeight * 2),
                        Text(
                          "Samahani, usajili wako umesitishwa.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: blockWidth * 6,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: blockHeight * 2),
                        Text(
                          "Tafadhali lipia tena ili uweze kuendelea kupata huduma hii.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: blockWidth * 5,
                              fontWeight: FontWeight.w300),
                        )
                      ],
                    ),
                  ),
                ),
                ProfileScreen(this.widget.currentUser),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
