import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:pregnancy_tracking_app/Screens/sajili/sajili.dart';
import 'package:pregnancy_tracking_app/Screens/signUP/regitration.dart';
import 'package:pregnancy_tracking_app/Screens/home/homeScreen.dart';
import 'package:pregnancy_tracking_app/Screens/signUP/signUp.dart';
import 'package:pregnancy_tracking_app/models/user.dart';
import 'package:pregnancy_tracking_app/shared/timeCalculate.dart';

class AuthService {
  String phoneNo;
  String verificationId;
  String status;
  User1 loginUser;
  TimeCalculate time = TimeCalculate();
  final firestoreInstance = FirebaseFirestore.instance;

  Future<void> verifyPhone(User1 loginUser, BuildContext context) async {
    this.loginUser = loginUser;
    phoneNo = loginUser.mobileNumber;

    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
      print("auto retrieve called");
      verificationId = verId;
    };

    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
      print("code sent: ${(verId)}");
      verificationId = verId;
    };

    final PhoneVerificationCompleted verifiedSuccess =
        (AuthCredential credential) async {
      print("success called");
      // AuthResult result = await FirebaseAuth.instance.signInWithCredential(credential);
      UserCredential result = await FirebaseAuth.instance.signInWithCredential(credential);
      User user = result.user;
      loginUser.mobileNumber = user.phoneNumber;
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Registration(this.loginUser),
        ),
      );
    };

    final PhoneVerificationFailed veriFailed = (FirebaseAuthException  exception) {
      print("failed called");
      print(exception.message);
      if (exception.message.contains('We have blocked all requests from this device')){
        status ="Tumefungia account hii kwasababu ya shughuli zisizo za kawaida";
      }
      if (exception.message.contains('not authorized')){
        status = 'Something has gone wrong, please try later';
      }
      else if (exception.message.contains('Network')){
        status = 'Please check your internet connection and try again';
      }else {
        status = exception.message;
      }

        showDialog(
          context: context,
          builder: (BuildContext bc){
              return AlertDialog(
                title: Center(
                  child: Text('Tatizo'),
                ),
                content: Text(status),
                actions: [
                  FlatButton(
                    onPressed: ()=>Navigator.pop(context),
                    child: Text('ok'),
                  )
                ],
              );
          }
        );
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNo,
      codeAutoRetrievalTimeout: autoRetrieve,
      codeSent: smsCodeSent,
      timeout: const Duration(seconds: 5),
      verificationCompleted: verifiedSuccess,
      verificationFailed: veriFailed,
    );
  }

  signUp(String smsCode, BuildContext context) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      final AuthCredential authCredential = PhoneAuthProvider.credential(
      smsCode: smsCode,
      verificationId: verificationId,
    );
      // AuthCredential authCredential = PhoneAuthProvider.getCredential(
      //     verificationId: verificationId, smsCode: smsCode);
      UserCredential result = await auth.signInWithCredential(authCredential);
      User user = result.user;
      loginUser.mobileNumber = user.phoneNumber;
      User currentUser = await auth.currentUser;
      assert(user.uid == currentUser.uid);
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Registration(this.loginUser),
        ),
      );
    } catch (e) {
      handleError(e, context);
    }
  }

  signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (_) => Sajili()));
    // Navigator.pushReplacementNamed(context, '/welcomePage');
  }

  // Future<FirebaseUser> checkSignIn() async {
  //   FirebaseUser user = await FirebaseAuth.instance.currentUser();
   Future<User> checkSignIn() async {
    User user = await FirebaseAuth.instance.currentUser;
    return user;
  }

  signIn(BuildContext context, String documentKey) {
    firestoreInstance
        .collection("users")
        .doc(documentKey)
        .get()
        .then((dataSnap) {
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(documentKey),
        ),
      );
    });
  }

  handleError(PlatformException error, BuildContext context) {
    switch (error.code) {
      case 'ERROR_INVALID_VERIFICATION_CODE':
        FocusScope.of(context).requestFocus(new FocusNode());
        status = 'Invalid Code';
        break;
      default:
        status = error.message;
        break;
    }
  }
}

