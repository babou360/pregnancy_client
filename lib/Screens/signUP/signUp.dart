import 'package:flutter/material.dart';
import 'package:pregnancy_tracking_app/app/sizeConfig.dart';
import 'package:pregnancy_tracking_app/models/user.dart';
import 'package:pregnancy_tracking_app/Screens/signUP/mobileVerf.dart';
import 'package:pregnancy_tracking_app/shared/timeCalculate.dart';
import 'package:pregnancy_tracking_app/widget/CustomButton.dart';
import 'package:pregnancy_tracking_app/widget/CustomDesignUI.dart';
import 'package:pregnancy_tracking_app/widget/CustomInputField.dart';
import 'package:pregnancy_tracking_app/widget/CustomTitle.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final mobileController = TextEditingController();

  User loginUser = User();
  TimeCalculate shared = TimeCalculate();

  @override
  Widget build(BuildContext context) {
    double blockHeight = SizeConfig.safeBlockVertical;
    double blockWidth = SizeConfig.safeBlockHorizontal;

    mobileVerify() {
      if (_formKey.currentState.validate()) {
        this.loginUser.mobileNumber = setMobileNumber(mobileController.text);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MobileVerfy(
              this.loginUser,
            ),
          ),
        );
      } else {
        ("****form is not valid****");
      }
    }

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                CustomDesignUI(
                  imagePath: 'images/pageDeco/top3.png',
                  color: Color.fromRGBO(174, 213, 129, 0.6),
                  height: blockHeight * 18,
                  top: 0,
                  left: 0,
                ),
                CustomDesignUI(
                  imagePath: 'images/pageDeco/bottom3.png',
                  color: Color.fromRGBO(197, 225, 165, 0.6),
                  height: blockHeight * 18,
                  bottom: 0,
                  right: 0,
                ),
                SizedBox(height: blockHeight * 10),
                CustomTitle(
                  title: "Sign Up",
                  top: blockHeight * 7,
                  right: blockWidth * 10,
                ),
                Container(
                  child: Column(
                    children: [
                      SizedBox(height: blockHeight * 20),
                      Container(
                        height: blockHeight * 40,
                        child: Image.asset("images/signup.jpg"),
                      ),
                      SizedBox(height: blockHeight * 10),
                      Form(
                        key: _formKey,
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: blockWidth * 15),
                          child: CustomInputField(
                            hintText: "Phone Number",
                            isPass: false,
                            fieldType: "mobile",
                            prefixIcon: Icons.phone_android,
                            fieldController: mobileController,
                            inputType: TextInputType.number,
                          ),
                        ),
                      ),
                      SizedBox(height: blockHeight * 3),
                      CustomButton(
                        title: "Next",
                        width: blockWidth * 70,
                        bgColor: Colors.green[400],
                        textColor: Colors.white,
                        height: blockHeight * 7,
                        fontSize: blockHeight * 3,
                        callback: mobileVerify,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  setMobileNumber(String phoneNumber) {
    phoneNumber = "+255" + phoneNumber;
    return phoneNumber;
  }
}
