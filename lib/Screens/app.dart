import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:pregnancy_tracking_app/Screens/auth/splash.dart';
import 'package:pregnancy_tracking_app/Screens/auth/welcomeScreen.dart';
import 'package:pregnancy_tracking_app/models/user.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      title: "Mama na Mwana",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      home: WelcomeScreen(),
      // home: Splash(),
      routes: {
        '/welcomePage': (context) => WelcomeScreen(),
      },
    );
  }
}
