import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pregnancy_tracking_app/Screens/home/homeScreen.dart';
import 'package:pregnancy_tracking_app/Screens/signIN/signIn.dart';
import 'package:pregnancy_tracking_app/Screens/signUP/signUp.dart';
import 'package:pregnancy_tracking_app/app/globals.dart';
import 'package:pregnancy_tracking_app/app/sizeConfig.dart';
import 'package:pregnancy_tracking_app/models/user.dart';
import 'package:pregnancy_tracking_app/services/authService.dart';
import 'package:pregnancy_tracking_app/widget/CustomButton.dart';
import 'package:pregnancy_tracking_app/widget/CustomDesignUI.dart';
import 'package:pregnancy_tracking_app/widget/CustomTitle.dart';


class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  AuthService _authService = AuthService();
  bool isSignIn = true;
  @override
  void initState() {
    super.initState();
    _authService.checkSignIn().then((user) {
    //  Future.delayed(Duration(seconds: 5),()=>
    // Navigator.of(context).pushReplacement(MaterialPageRoute(
    // builder: (BuildContext context) =>
    // StreamBuilder(
    //   stream: auth.onAuthStateChanged,
    //   builder:  (context,snapshot){
    //     if(snapshot.hasData){
    //       return HomeScreen();
    //       // return WelcomeScreen();
    //     }else{
    //       // return LoginRegister();
    //       return SignUp();
    //     }
    //   }))
    // ));
      setState(() {
        if (user == null) {
          isSignIn = false;
        } else {
          isSignIn = true;
          Future.delayed(Duration(seconds: 5), () {
            // _authService.signIn(context, user.phoneNumber);
            _authService.signIn(context, user.phoneNumber);
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
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              CustomDesignUI(
                imagePath: 'images/pageDeco/top1.png',
                color: Color.fromRGBO(174, 213, 129, 0.6),
                height: blockHeight * 25,
                top: 0,
                left: 0,
              ),
              CustomDesignUI(
                imagePath: 'images/pageDeco/bottom1.png',
                color: Color.fromRGBO(197, 225, 165, 0.6),
                height: blockHeight * 20,
                left: 0,
                bottom: 0,
              ),
              Positioned(
                top: blockHeight * 40,
                right: -blockWidth * 15,
                child: CircleAvatar(
                  radius: blockWidth * 15,
                  backgroundColor: Color.fromRGBO(220, 237, 200, 1),
                ),
              ),
              SizedBox(height: blockHeight * 10),
              CustomTitle(
                title: "Welcome",
                top: blockHeight * 7,
                right: blockWidth * 8,
              ),
              Container(
                child: Column(
                  children: [
                    SizedBox(height: blockHeight * 25),
                    Container(
                      height: blockHeight * 40,
                      child: Image.asset("images/logo/logoIconDef.png"),
                    ),
                    SizedBox(height: blockHeight * 6),
                    isSignIn
                        ? Container(
                            width: double.infinity,
                            child: Column(
                              children: <Widget>[
                                Text(
                                  "Kuwa mama bora,",
                                  style: TextStyle(
                                      fontSize: blockWidth * 7,
                                      fontWeight: FontWeight.w300),
                                ),
                                Text(
                                  "Toka siku ya kwanza.",
                                  style: TextStyle(
                                      fontSize: blockWidth * 7,
                                      fontWeight: FontWeight.w300),
                                ),
                              ],
                            ),
                          )
                        : CustomButton(
                            title: "Sign UP",
                            width: blockWidth * 60,
                            bgColor: Colors.green[50],
                            textColor: Colors.black87,
                            callback: goToSignUp,
                          )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
