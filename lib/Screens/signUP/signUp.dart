import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pregnancy_tracking_app/app/sizeConfig.dart';
import 'package:pregnancy_tracking_app/models/user.dart';
import 'package:pregnancy_tracking_app/Screens/signUP/mobileVerf.dart';
import 'package:pregnancy_tracking_app/shared/timeCalculate.dart';
import 'package:pregnancy_tracking_app/widget/CustomButton.dart';
import 'package:pregnancy_tracking_app/widget/CustomDesignUI.dart';
import 'package:pregnancy_tracking_app/widget/CustomTitle.dart';
import 'package:country_code_picker/country_code_picker.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final mobileController = TextEditingController();
  String _code;

  User1 loginUser = User1();
  TimeCalculate shared = TimeCalculate();

  @override
  Widget build(BuildContext context) {
    double blockHeight = SizeConfig.safeBlockVertical;
    double blockWidth = SizeConfig.safeBlockHorizontal;

    void _onCountryChange(CountryCode countryCode) {
      setState(() {
        _code = countryCode.toString();
      });
      print("New Country selected: " + countryCode.toString());
    }

    mobileVerify() {
      if(mobileController.text.isEmpty){
        Fluttertoast.showToast(
          msg: "Hujaweka namba ya simu",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
      }else if(mobileController.text.startsWith('0')){
        Fluttertoast.showToast(
          msg: "Usianze na  0 kwenye namba",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
      }else if(mobileController.text.length < 9){
        Fluttertoast.showToast(
          msg: "Namba lazima iwe na tarakimu 9",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
      }else if(mobileController.text.length>9){
        Fluttertoast.showToast(
          msg: "Namba si zaidi ya tarakimu 9",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
      }else{
        this.loginUser.mobileNumber = setMobileNumber(mobileController.text);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MobileVerfy(
              this.loginUser,
            ),
          ),
        );
      }
      // if (_formKey.currentState.validate()) {
      //   this.loginUser.mobileNumber = setMobileNumber(mobileController.text);
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => MobileVerfy(
      //         this.loginUser,
      //       ),
      //     ),
      //   );
      // } else {
      //   ("****form is not valid****");
      // }
    }

    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: ()=> mobileVerify(),
          child: Icon(Icons.navigate_next,size: 40,),
        ),
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
                  title: "Sign In",
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
                          //key: _formKey,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                // color: Colors.grey[800],
                                color: Colors.green[200],
                                borderRadius: BorderRadius.all(Radius.circular(20))
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width / 4,
                                      child: CountryCodePicker(
                                        textStyle: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey[800]
                                        ),
                                        onChanged: _onCountryChange,
                                        initialSelection: 'TZ',
                                        favorite: ['+255', 'TZ'],
                                        showCountryOnly: false,
                                        showOnlyCountryWhenClosed: false,
                                        alignLeft: false,
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width/1.7,
                                      child: TextFormField(
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey[600],
                                          fontFamily: '',
                                        ),
                                        controller: mobileController,
                                        keyboardType: TextInputType.number,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Phone Cannot be empty';
                                          } else if (value.startsWith('0')) {
                                            return 'Cannot start with 0';
                                          } else if (value.length < 9) {
                                            return 'Maxmum 9 Numbers';
                                          } else if (value.length > 9) {
                                            return 'Minimum 9 numbers';
                                          } else {
                                            return null;
                                          }
                                        },
                                        decoration: InputDecoration(
                                          // labelText: 'Phone Number',
                                          hintText: 'Nambari ya simu',
                                          border: InputBorder.none,
                                          hintStyle: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.grey[500],
                                          )
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )),
                      // SizedBox(height: blockHeight * 3),
                      // CustomButton(
                      //   title: "Next",
                      //   width: blockWidth * 70,
                      //   bgColor: Colors.green[400],
                      //   textColor: Colors.white,
                      //   height: blockHeight * 7,
                      //   fontSize: blockHeight * 3,
                      //   callback: mobileVerify,
                      // )
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
    phoneNumber = _code == null? '+255${(phoneNumber)}': _code + phoneNumber;
    return phoneNumber;
  }
}
