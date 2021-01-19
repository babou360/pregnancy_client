import 'package:flutter/material.dart';
import 'package:pregnancy_tracking_app/services/authService.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  AuthService _authService = AuthService();
  String _mobileNumber;
  String _password;
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordShow = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Positioned(
                  height: 130.0,
                  top: 0.0,
                  right: 0.0,
                  child: Image.asset(
                    'images/pageDeco/top2.png',
                    color: Color.fromRGBO(174, 213, 129, 0.6),
                  ),
                ),
                Positioned(
                  height: 140.0,
                  bottom: 0.0,
                  left: 0.0,
                  child: Image.asset(
                    'images/pageDeco/bottom2.png',
                    color: Color.fromRGBO(197, 225, 165, 0.6),
                  ),
                ),
                Positioned(
                  top: 30.0,
                  left: 60,
                  child: Center(
                    child: Text(
                      "Log In",
                      style: TextStyle(
                        color: Colors.teal[900],
                        fontSize: 35.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 90.0,
                  child: Center(
                    child: Container(
                      height: 180.0,
                      child: Image.asset("images/login.jpg"),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 300.0, left: 55.0, right: 55.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10.0),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50.0)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50.0)),
                              ),
                              prefixIcon: Icon(Icons.person),
                              hintText: "Phone Number",
                              filled: true,
                              fillColor: Colors.green[50],
                              border: InputBorder.none,
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter mobile number ';
                              } else {
                                return null;
                              }
                            },
                            onChanged: (value) {
                              setState(() {
                                this._mobileNumber = value;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 15.0),
                        Container(
                          child: TextFormField(
                            obscureText: _isPasswordShow,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10.0),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50.0)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50.0)),
                              ),
                              prefixIcon: Icon(Icons.vpn_key),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isPasswordShow = !_isPasswordShow;
                                  });
                                },
                                child: Icon(
                                  _isPasswordShow
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              ),
                              hintText: "Password",
                              filled: true,
                              fillColor: Colors.green[50],
                              border: InputBorder.none,
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter password';
                              } else {
                                return null;
                              }
                            },
                            onChanged: (value) {
                              setState(() {
                                this._password = value;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 45.0),
                        Container(
                          height: 45.0,
                          width: double.infinity,
                          child: FlatButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                                side: BorderSide(color: Colors.green[400]),
                              ),
                              color: Colors.green[400],
                              textColor: Colors.white,
                              splashColor: Colors.green[200],
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              onPressed: () {}),
                        ),
                        SizedBox(height: 15.0),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            "Forgot Password ?",
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, '/signUp');
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              fontWeight: FontWeight.w200,
                              color: Colors.black54,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
