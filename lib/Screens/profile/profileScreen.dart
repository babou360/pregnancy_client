import 'package:flutter/material.dart';
import 'package:pregnancy_tracking_app/Screens/profile/PersonalInfo.dart';
import 'package:pregnancy_tracking_app/Screens/profile/paymentInfo.dart';
import 'package:pregnancy_tracking_app/Screens/profile/pregCalculation.dart';
import 'package:pregnancy_tracking_app/Screens/profile/pregInfo.dart';
import 'package:pregnancy_tracking_app/app/sizeConfig.dart';
import 'package:pregnancy_tracking_app/models/user.dart';
import 'package:pregnancy_tracking_app/services/authService.dart';
import 'package:pregnancy_tracking_app/services/databaseService.dart';
import 'package:pregnancy_tracking_app/widget/CustomButton.dart';

class ProfileScreen extends StatefulWidget {
  User currentUser;
  ProfileScreen(this.currentUser);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  double blockHeight = SizeConfig.safeBlockVertical;
  double blockWidth = SizeConfig.safeBlockHorizontal;
  DatabaseService dbs = DatabaseService();
  onClickLogout() {
    var authService = AuthService();
    authService.signOut(this.context);

    // dbs.getSubscriptions(this.widget.currentUser.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          PersonalInfo(this.widget.currentUser),
          PregnancyInfo(this.widget.currentUser),
          PregnancyCalculation(this.widget.currentUser),
          PaymentInfo(this.widget.currentUser),
          SizedBox(height: 15.0),
          CustomButton(
            title: "Logout",
            bgColor: Colors.green[400],
            textColor: Colors.white,
            callback: onClickLogout,
            width: blockWidth * 75,
          ),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }
}
