// import 'package:flutter/material.dart';
// import 'Screens/app.dart';

// void main() => runApp(App());

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pregnancy_tracking_app/services/authService.dart';
import 'package:pregnancy_tracking_app/Screens/home/homeScreen.dart';
import 'package:pregnancy_tracking_app/Screens/signUP/signUp.dart';
import 'package:pregnancy_tracking_app/Screens/auth/welcomeScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void initState() {
    super.initState();
    signIn();
  }

  @override
  Widget firstWidget;

  final FirebaseAuth auth = FirebaseAuth.instance;
  AuthService _authService = AuthService();

  signIn() {
    _authService.checkSignIn().then((user) {
      setState(() {
        if (user == null) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => SignUp()));
          // firstWidget = SignUp();
        } else {
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
            // firstWidget = HomeScreen(user.phoneNumber);
          });
        }
      });
    });
  }

  Widget build(BuildContext context) {
    // return FutureBuilder(
    //   future: FirebaseAuth.instance.currentUser(),
    //   builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot){
    //     if (snapshot.hasData){
    //       // Firestore.instance
    //       //     .collection('users')
    //       //     .document(user.phoneNumber)
    //       //     .get()
    //       //     .then((value) {});
    //       return SignUp();
    //     }else{
    //       return SignUp();
    //     }
    //   },
    // );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'mama na mwana',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: WelcomeScreen(),
      //firstWidget
    );
  }
}
