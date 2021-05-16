import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:pregnancy_tracking_app/app/sizeConfig.dart';
import 'package:pregnancy_tracking_app/models/user.dart';
import 'package:pregnancy_tracking_app/Screens/imageSlider/slider.dart';
import 'package:pregnancy_tracking_app/services/databaseService.dart';
import 'package:pregnancy_tracking_app/widget/CustomButton.dart';
import 'package:pregnancy_tracking_app/widget/CustomDesignUI.dart';
import 'package:pregnancy_tracking_app/widget/CustomInputField.dart';
import 'package:pregnancy_tracking_app/widget/CustomTitle.dart';

class Registration extends StatefulWidget {
  User1 loginUser;
  Registration(this.loginUser);
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  double blockHeight = SizeConfig.safeBlockVertical;
  double blockWidth = SizeConfig.safeBlockHorizontal;
  final DatabaseService _databaseService = DatabaseService();

  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  Stream userStream;
  DateTime pickedDate;
  bool _isDateSelect = false,
  isNew = true;
  String _errorText = '';
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    userStream = _databaseService.getUser(this.widget.loginUser.mobileNumber);
  }

  

  onClickRegister() {
    setState(() {
      isLoading = true;
    });
    if (!_isDateSelect) {
      setState(() {
        _errorText = 'Tafadhali ingiza tarehe ya mwisho ya hedhi';
        // _errorText = 'Please enter last period date';
      });
    } else {
      this.widget.loginUser.name = this.nameController.text;
      this.widget.loginUser.age = int.parse(this.ageController.text);
      this.widget.loginUser.lastPeriodDate = this.pickedDate;
      this.widget.loginUser.dueDate =
          this.widget.loginUser.lastPeriodDate.add(Duration(days: 280));
      this._databaseService.createUser(this.widget.loginUser, isNew);
      setState(() {
        isLoading = false;
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SliderPage(this.widget.loginUser),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: userStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData && snapshot.data.exists) {
          nameController.text = snapshot.data["name"];
          ageController.text = snapshot.data["age"].toString();
          this.widget.loginUser.profileImageURL = snapshot.data["profileImage"];
          this.widget.loginUser.bloodCount = snapshot.data["bloodCount"];
          this.widget.loginUser.weight = snapshot.data["weight"];
          this.widget.loginUser.lastPeriodDate =
              snapshot.data["lastPeriodDate"].toDate();
          this.widget.loginUser.dueDate = snapshot.data["dueDate"].toDate();
          this.widget.loginUser.renewalDate =snapshot.data["renewalDate"].toDate();
          this.widget.loginUser.payDate =snapshot.data["payDate"].toDate();
          this.widget.loginUser.joinedAt = snapshot.data["joinedAt"].toDate();
          _isDateSelect = true;
          this.pickedDate = this.widget.loginUser.lastPeriodDate;
          isNew = false;
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
                      imagePath: 'images/pageDeco/top2.png',
                      color: Color.fromRGBO(174, 213, 129, 0.6),
                      height: blockWidth * 30,
                      top: 0,
                      right: 0,
                    ),
                    CustomDesignUI(
                      imagePath: 'images/pageDeco/bottom2.png',
                      color: Color.fromRGBO(174, 213, 129, 0.6),
                      height: blockWidth * 35,
                      bottom: 0,
                      left: 0,
                    ),
                    CustomTitle(
                      title: isNew? "Register": "Login",
                      top: blockHeight * 7,
                      left: blockWidth * 15,
                    ),
                    Container(
                      child: Column(
                        children: [
                          SizedBox(height: blockHeight * 15),
                          Container(
                            height: blockHeight * 40,
                            child: Image.asset("images/registration.jpg"),
                          ),
                          Form(
                            key: _formKey,
                            child: isNew
                            ? Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: blockWidth * 15),
                              child: Column(
                                children: [
                                   CustomInputField(
                                          hintText: "Jina",
                                          isPass: false,
                                          fieldType: "text",
                                          prefixIcon: Icons.keyboard,
                                          fieldController: nameController,
                                        ),
                                  SizedBox(height: blockHeight * 2),
                                   CustomInputField(
                                          hintText: "Umri",
                                          isPass: false,
                                          fieldType: "text",
                                          prefixIcon: Icons.keyboard,
                                          fieldController: ageController,
                                          inputType: TextInputType.number,
                                        ),
                                  SizedBox(height: blockHeight * 2),
                                   InkWell(
                                          onTap: () {
                                            setState(() {
                                              _pickDate(context);
                                            });
                                          },
                                          child: Container(
                                            height: 55.0,
                                            width: double.infinity,
                                            child: SizedBox(
                                              width: double.infinity,
                                              child: Card(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                                elevation: 0,
                                                color: Colors.green[50],
                                                child: Row(
                                                  children: <Widget>[
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 10.0),
                                                      child: Icon(
                                                        Icons.calendar_today,
                                                        color: Colors.black54,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 10.0),
                                                      child: Text(
                                                        () {
                                                          if (!_isDateSelect) {
                                                            return "mwisho wa hedhi";
                                                            // return "Last period start date";
                                                          } else {
                                                            return pickedDate
                                                                    .day
                                                                    .toString() +
                                                                " - " +
                                                                pickedDate.month
                                                                    .toString() +
                                                                " - " +
                                                                pickedDate.year
                                                                    .toString();
                                                          }
                                                        }(),
                                                        style: TextStyle(
                                                          fontSize: 16.0,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Colors.black54,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                  Text(
                                    _errorText,
                                    style: TextStyle(
                                        fontSize: 11.5, color: Colors.red[700]),
                                  ),
                                ],
                              ),
                            )
                            :SizedBox.shrink()
                          ),
                          SizedBox(height: blockHeight * 3),
                          CustomButton(
                            title: isNew
                                ? isLoading? CircularProgressIndicator(): 'Sign Up'
                                : isLoading ? CircularProgressIndicator():"Sign In",
                            width: blockWidth * 70,
                            bgColor: Colors.green[400],
                            textColor: Colors.white,
                            height: blockHeight * 7,
                            fontSize: blockHeight * 3,
                            callback: onClickRegister,
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
      },
    );
  }

  Future<Null> _pickDate(BuildContext context) async {
    DateTime _date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().month - 10),
      lastDate: DateTime.now(),
    );
    if (_date != null) {
      setState(() {
        _isDateSelect = true;
        _errorText = '';
        pickedDate = _date;
        // pickedDate = (_date.toUtc());
      });
    }
  }
}
