import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pregnancy_tracking_app/Screens/sajili/home.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:pregnancy_tracking_app/Screens/signUP/regitration.dart';
import 'package:pregnancy_tracking_app/models/user.dart';

class OTPScreen extends StatefulWidget {
  OTPScreen(this.loginUser);
  User1 loginUser;
  // final String phone;
  // OTPScreen(this.phone);
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  String _verificationCode;
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color:  Colors.transparent,
    // color: const Color.fromRGBO(43, 46, 66, 1),
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: Colors.green,
      // color: const Color.fromRGBO(126, 203, 224, 1),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldkey,
        // appBar: AppBar(
        //   title: Text('OTP Verification'),
        // ),
        body: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                margin: EdgeInsets.only(top: 40),
                child: Column(
                  children: [
                    Text('Thibitisha Namba Yako',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 26,color: Colors.grey[800])),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RichText(
                        textAlign: TextAlign.center,
                      text: TextSpan(
                        text: "tafadhali ingiza Code iliotumwa kwenye namba ",
                        children: <TextSpan>[
                          TextSpan(
                            text: this.widget.loginUser.mobileNumber,
                            style: TextStyle(
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w300,
                          color: Colors.black54,
                        ),
                      ),
                  ),
                    ),
                  ],
                ),
                // child: Center(
                //   child: Text(
                //     //  'Verify +255${widget.phone}',
                //     'Thibitisha ${this.widget.loginUser.mobileNumber}',
                //     style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20,color: Colors.grey[600]),
                //   ),
                // ),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: PinPut(
                  fieldsCount: 6,
                  textStyle: const TextStyle(fontSize: 25.0, color: Colors.black),
                  eachFieldWidth: 40.0,
                  eachFieldHeight: 55.0,
                  focusNode: _pinPutFocusNode,
                  controller: _pinPutController,
                  submittedFieldDecoration: pinPutDecoration,
                  selectedFieldDecoration: pinPutDecoration,
                  followingFieldDecoration: pinPutDecoration,
                  pinAnimationType: PinAnimationType.fade,
                  onSubmit: (pin) async {
                    try {
                      await FirebaseAuth.instance
                          .signInWithCredential(PhoneAuthProvider.credential(
                              verificationId: _verificationCode, smsCode: pin))
                          .then((value) async {
                        if (value.user != null) {
                          User user = value.user;
                          this.widget.loginUser.mobileNumber = user.phoneNumber;
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => Registration(this.widget.loginUser)),
                              (route) => false);
                        }
                      });
                    } catch (e) {
                      FocusScope.of(context).unfocus();
                      _scaffoldkey.currentState
                          .showSnackBar(SnackBar(content: Text('Code sio sahihi',style: TextStyle(fontWeight: FontWeight.w600))));
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: this.widget.loginUser.mobileNumber,
        //  phoneNumber: '+255${widget.phone}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              User user = value.user;
              this.widget.loginUser.mobileNumber = user.phoneNumber;
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Registration(this.widget.loginUser)),
                  // MaterialPageRoute(builder: (context) => Home()),
                  (route) => false);
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String verficationID, int resendToken) {
          setState(() {
            _verificationCode = verficationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: Duration(seconds: 120));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _verifyPhone();
  }
}