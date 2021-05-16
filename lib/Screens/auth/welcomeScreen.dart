import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pregnancy_tracking_app/Screens/home/homeScreen.dart';
import 'package:pregnancy_tracking_app/Screens/signUP/signUp.dart';
import 'package:pregnancy_tracking_app/app/globals.dart';
import 'package:pregnancy_tracking_app/app/sizeConfig.dart';
import 'package:pregnancy_tracking_app/services/authService.dart';
import 'package:pregnancy_tracking_app/Screens/sajili/sajili.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  AuthService _authService = AuthService();
   final spinkit = SpinKitFadingCube(
  itemBuilder: (BuildContext context, int index) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: index.isEven ? Colors.red : Colors.green,
      ),
    );
  },
);
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
              builder: (context) => Sajili()
              //builder: (context) => SignUp()
            )
          );
        } else {
          isSignIn = true;
          Future.delayed(Duration(seconds: 3), () {
            // _authService.signIn(context, user.phoneNumber);
            FirebaseFirestore.instance
                .collection('users')
                .doc(user.phoneNumber)
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
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.grey[800],
        body: Center(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.asset('images/logo/mamak.png')),
          // child: spinkit,
        )
      ),
    );
  }
}
