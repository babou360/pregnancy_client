import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pregnancy_tracking_app/Screens/home/homeScreen.dart';
import 'package:pregnancy_tracking_app/Screens/signUP/signUp.dart';
import 'package:pregnancy_tracking_app/app/globals.dart';
import 'package:pregnancy_tracking_app/app/sizeConfig.dart';
import 'package:pregnancy_tracking_app/services/authService.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  AuthService _authService = AuthService();
  // static final birthday = DateTime(1967, 10, 12);
  // static final date2 = DateTime.now();
  // final difference = date2.difference(birthday).inDays;
  bool isSignIn = true;
  @override
  void initState() {
    super.initState();
    _authService.checkSignIn().then((user) {
      setState(() {
        if (user == null) {
          // isSignIn = false;
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => SignUp()
            )
          );
        } else {
          isSignIn = true;
          Future.delayed(Duration(seconds: 3), () {
            // _authService.signIn(context, user.phoneNumber);
            Firestore.instance
                .collection('users')
                .document(user.phoneNumber)
                .get()
                .then((value) {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(user.phoneNumber),
                    ),
                  );
                });
          });
        }
      });
    });
  }

  goToSignUp() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUp()),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double blockHeight = SizeConfig.safeBlockVertical;
    double blockWidth = SizeConfig.safeBlockHorizontal;

    Globals.addBlockHeightAndWidth(blockHeight, blockWidth);
    return Scaffold(
      // backgroundColor: Colors.grey[800],
      body: Center(
        child: CircularProgressIndicator(),
      )
    );
  }
}
