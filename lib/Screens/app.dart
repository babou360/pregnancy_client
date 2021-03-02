import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:pregnancy_tracking_app/Screens/auth/welcomeScreen.dart';
import 'package:pregnancy_tracking_app/services/authService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pregnancy_tracking_app/Screens/home/homeScreen.dart';
import 'package:pregnancy_tracking_app/Screens/signUP/signUp.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     
      Widget firstWidget;

     final FirebaseAuth auth = FirebaseAuth.instance;
      AuthService _authService = AuthService();
      
      _authService.checkSignIn().then((user) {
        if (user == null) {
            firstWidget =SignUp();
          }else{
            firstWidget= HomeScreen(user.phoneNumber);
          }
      });
    return MaterialApp(
      // builder: BotToastInit(),
      // navigatorObservers: [BotToastNavigatorObserver()],
      title: "Mama na Mwana",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
         brightness: Brightness.dark,
         primaryColor: Colors.green[400],
         accentColor: Colors.cyan[600],
         backgroundColor: Colors.white,
        //  fontFamily: 'kafeez',
        scaffoldBackgroundColor: Colors.white,

        textTheme: TextTheme(
        bodyText1: TextStyle(fontSize: 14.0, fontFamily: 'Hind',color: Colors.black),
        headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold,color: Colors.black),
        headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.normal,color: Colors.black),
        bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind',color: Colors.black),
      ),
      ),
      home: firstWidget,
      //WelcomeScreen(),
      // home: Splash(this.loginUser),
      routes: {
        '/welcomePage': (context) => WelcomeScreen(),
        '/signUp': (context) => SignUp(),
        // '/homeScreen': (context) => HomeScreen(user.),
      },
    );
  }
}


