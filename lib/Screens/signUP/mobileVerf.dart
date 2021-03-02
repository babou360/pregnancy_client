import 'package:flutter/material.dart';
import 'package:pregnancy_tracking_app/Screens/signUP/PInNumber.dart';
import 'package:pregnancy_tracking_app/Screens/signUP/keyboardNumber.dart';
import 'package:pregnancy_tracking_app/Screens/signUP/regitration.dart';
import 'package:pregnancy_tracking_app/app/sizeConfig.dart';
import 'package:pregnancy_tracking_app/services/authService.dart';
import 'package:pregnancy_tracking_app/models/user.dart';
import 'package:pregnancy_tracking_app/widget/CustomButton.dart';
import 'package:pregnancy_tracking_app/widget/CustomDesignUI.dart';
import 'package:pregnancy_tracking_app/widget/CustomTitle.dart';

class MobileVerfy extends StatefulWidget {
  MobileVerfy(this.loginUser);
  User loginUser;

  @override
  _MobileVerfyState createState() => _MobileVerfyState();
}

class _MobileVerfyState extends State<MobileVerfy> {
  double blockHeight = SizeConfig.safeBlockVertical;
  double blockWidth = SizeConfig.safeBlockHorizontal;

  final AuthService _authService = AuthService();
  @override
  void initState() {
    _authService.verifyPhone(this.widget.loginUser, context);
    super.initState();
  }

  verifyMobile() {
    _authService.signUp(this.smsCode, context);
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Registration(this.widget.loginUser),
      ),
    );
  }

  resendCode() {
    print('resend code clicked');
  }

  String smsCode;
  int pinIndex = 0;
  List<String> currentPin = ["", "", "", "", "", ""];
  TextEditingController firstPinController = TextEditingController();
  TextEditingController secondPinController = TextEditingController();
  TextEditingController thirdPinController = TextEditingController();
  TextEditingController fourthPinController = TextEditingController();
  TextEditingController fifthPinController = TextEditingController();
  TextEditingController sixthPinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Builder(
          builder: (context) {
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    CustomDesignUI(
                      imagePath: 'images/pageDeco/top2.png',
                      color: Color.fromRGBO(174, 213, 129, 0.6),
                      height: blockWidth * 25,
                      right: 0,
                      top: 0,
                    ),
                    CustomDesignUI(
                      imagePath: 'images/pageDeco/bottom2.png',
                      color: Color.fromRGBO(197, 225, 165, 0.6),
                      height: blockWidth * 40,
                      bottom: 0,
                      left: 0,
                    ),
                    CustomTitle(
                      title: "Thibitisha ",
                      top: blockHeight * 7,
                      left: blockWidth * 10,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: blockWidth * 10),
                      child: Column(
                        children: [
                          SizedBox(height: blockHeight * 20),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Center(
                              child: RichText(
                                text: TextSpan(
                                  text:
                                      "tafadhali ingiza msibo uliotumwa kwenye namba ",
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: this.widget.loginUser.mobileNumber,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: blockHeight * 5),
                          Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            child: otpPinRow(),
                          ),
                          SizedBox(height: blockHeight * 5),
                          CustomButton(
                            title: "Thibitisha sasa",
                            width: blockWidth * 50,
                            bgColor: Colors.green[400],
                            textColor: Colors.white,
                            height: blockHeight * 6,
                            fontSize: blockHeight * 2.5,
                            callback: verifyMobile,
                          ),
                          SizedBox(height: blockHeight * 2),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Haukupata Msimbo ?   ",
                                  style: TextStyle(
                                    fontSize: blockWidth * 3.5,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black54,
                                  ),
                                ),
                                CustomButton(
                                  title: "Tuma",
                                  width: blockWidth * 25,
                                  bgColor: Colors.green[50],
                                  textColor: Colors.black54,
                                  height: blockHeight * 3.5,
                                  fontSize: blockHeight * 1.8,
                                  callback: resendCode,
                                ),
                              ],
                            ),
                          ),
                          // SizedBox(height: blockHeight * ),
                          Container(child: numberPad()),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  numberPad() {
    return Expanded(
      child: Container(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: blockHeight * 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  keyboardNumber(
                      number: 1,
                      onKeyPressed: () {
                        numberSetup("1");
                      }),
                  keyboardNumber(
                      number: 2,
                      onKeyPressed: () {
                        numberSetup("2");
                      }),
                  keyboardNumber(
                      number: 3,
                      onKeyPressed: () {
                        numberSetup("3");
                      }),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  keyboardNumber(
                      number: 4,
                      onKeyPressed: () {
                        numberSetup("4");
                      }),
                  keyboardNumber(
                      number: 5,
                      onKeyPressed: () {
                        numberSetup("5");
                      }),
                  keyboardNumber(
                      number: 6,
                      onKeyPressed: () {
                        numberSetup("6");
                      }),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  keyboardNumber(
                      number: 7,
                      onKeyPressed: () {
                        numberSetup("7");
                      }),
                  keyboardNumber(
                      number: 8,
                      onKeyPressed: () {
                        numberSetup("8");
                      }),
                  keyboardNumber(
                      number: 9,
                      onKeyPressed: () {
                        numberSetup("9");
                      }),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    width: blockWidth * 13,
                    child: SizedBox(),
                  ),
                  keyboardNumber(
                      number: 0,
                      onKeyPressed: () {
                        numberSetup("0");
                      }),
                  Container(
                    height: blockHeight * 6,
                    width: blockWidth * 13,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent,
                    ),
                    child: MaterialButton(
                      splashColor: Colors.green[100],
                      onPressed: () {
                        clearPin();
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(blockWidth * 50),
                      ),
                      child: Icon(
                        Icons.backspace,
                        color: Colors.green[300].withOpacity(0.8),
                        // fontWeight: FontWeight.w300,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  numberSetup(String textNumber) {
    if (pinIndex == 0) {
      pinIndex = 1;
    } else if (pinIndex < 6) {
      pinIndex++;
    }
    setPin(pinIndex, textNumber);
    currentPin[pinIndex - 1] = textNumber;
    String strPin = "";
    currentPin.forEach((element) {
      strPin += element;
    });
    if (pinIndex == 6) {
      this.smsCode = strPin;
    }
  }

  setPin(int n, String text) {
    switch (n) {
      case 1:
        firstPinController.text = text;
        break;
      case 2:
        secondPinController.text = text;
        break;
      case 3:
        thirdPinController.text = text;
        break;
      case 4:
        fourthPinController.text = text;
        break;
      case 5:
        fifthPinController.text = text;
        break;
      case 6:
        sixthPinController.text = text;
        break;
      default:
    }
  }

  otpPinRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        pinNumber(textEditingController: firstPinController),
        pinNumber(textEditingController: secondPinController),
        pinNumber(textEditingController: thirdPinController),
        pinNumber(textEditingController: fourthPinController),
        pinNumber(textEditingController: fifthPinController),
        pinNumber(textEditingController: sixthPinController),
      ],
    );
  }

  clearPin() {
    if (pinIndex == 0) {
      pinIndex = 0;
    } else if (pinIndex == 6) {
      setPin(pinIndex, "");
      currentPin[pinIndex - 1] = "";
      pinIndex--;
    } else {
      setPin(pinIndex, "");
      currentPin[pinIndex - 1] = "";
      pinIndex--;
    }
  }
}
