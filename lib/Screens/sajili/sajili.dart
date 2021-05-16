import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pregnancy_tracking_app/Screens/sajili/otp.dart';
import 'package:pregnancy_tracking_app/models/user.dart';

class Sajili extends StatefulWidget {
  @override
  _SajiliState createState() => _SajiliState();
}

class _SajiliState extends State<Sajili> {
  TextEditingController _controller = TextEditingController();
  User1 loginUser = User1();
  String _code;

  void _onCountryChange(CountryCode countryCode) {
      setState(() {
        _code = countryCode.toString();
      });
      print("New Country selected: " + countryCode.toString());
    }

    setMobileNumber(String phoneNumber) {
    phoneNumber = _code == null? '+255${(phoneNumber)}': _code + phoneNumber;
    return phoneNumber;
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(children: [
                Container(
                  height: 500,
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset("images/signup.jpg"),
                ),
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width /3,
                      margin: EdgeInsets.only(top: 30),
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
                      margin: EdgeInsets.only(top: 40, right: 0, left: 10),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'nambari ya simu',
                      // prefix: Padding(
                      //   padding: EdgeInsets.all(4),
                      //   child: CountryCodePicker(
                      //     textStyle: TextStyle(
                      //       fontWeight: FontWeight.w600,
                      //       color: Colors.grey[800]
                      //     ),
                      //     onChanged: _onCountryChange,
                      //     initialSelection: 'TZ',
                      //     favorite: ['+255', 'TZ'],
                      //     showCountryOnly: false,
                      //     showOnlyCountryWhenClosed: false,
                      //     alignLeft: false,
                      //   ),
                      //   // child: Text('+255'),
                      // ),
                    ),
                    maxLength: 9,
                    keyboardType: TextInputType.number,
                    controller: _controller,
                  ),
                )
                  ],
                ),
              ]),
              Container(
                margin: EdgeInsets.all(10),
                width: double.infinity,
                child: FlatButton(
                  color: Colors.green,
                  onPressed: () {
                    if(_controller.text.isEmpty){
                      Fluttertoast.showToast(
                        msg: "Hujaweka namba ya simu",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: 16.0);
                    }else if(_controller.text.startsWith('0')){
                      Fluttertoast.showToast(
                        msg: "Usianze na  0 kwenye namba",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: 16.0);
                    }else if(_controller.text.length < 9){
                      Fluttertoast.showToast(
                        msg: "Namba lazima iwe na tarakimu 9",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: 16.0);
                    }else if(_controller.text.length>9){
                      Fluttertoast.showToast(
                        msg: "Namba si zaidi ya tarakimu 9",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: 16.0);
                    }else{
                      this.loginUser.mobileNumber = setMobileNumber(_controller.text);
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => OTPScreen(this.loginUser)));
                      // Navigator.of(context).push(MaterialPageRoute(
                      //   builder: (context) => OTPScreen(_controller.text)));
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Next',
                      style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 20),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}