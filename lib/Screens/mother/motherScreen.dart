import 'package:flutter/material.dart';
import 'package:pregnancy_tracking_app/Screens/mother/motherWeek.dart';
import 'package:pregnancy_tracking_app/app/sizeConfig.dart';
import 'package:pregnancy_tracking_app/models/motherModel.dart';
import 'package:pregnancy_tracking_app/models/pregnancy.dart';
import 'package:pregnancy_tracking_app/models/user.dart';
import 'package:pregnancy_tracking_app/services/userDatabaseService.dart';
import 'package:pregnancy_tracking_app/widget/CustomLoading.dart';
import 'package:pregnancy_tracking_app/widget/ImageView.dart';

class MotherScreen extends StatefulWidget {
  User1 currentUser;
  MotherScreen(this.currentUser);

  @override
  _MotherScreenState createState() => _MotherScreenState();
}

class _MotherScreenState extends State<MotherScreen> {
  double blockHeight = SizeConfig.safeBlockVertical;
  double blockWidth = SizeConfig.safeBlockHorizontal;
  Pregnancy pregnancy = Pregnancy();
  UserDatabaseService _userDatabaseService = UserDatabaseService();
  int _selectedIndex;
  Stream motherMonthStram;
  Mother mother = Mother();

  @override
  void initState() {
    super.initState();
    pregnancy.updateValue(this.widget.currentUser);
    _selectedIndex = pregnancy.months;
    // motherMonthStram = _userDatabaseService.getMomMonth(_selectedIndex);
  }

  _onDaySelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: motherMonthStram,
        builder: (context, currentMonthSnap) {
          if (currentMonthSnap.hasData && currentMonthSnap.data.exists) {
            this.mother.month = int.parse(currentMonthSnap.data["month"]);
            //currentMonthSnap.data["month"];
            this.mother.imageURL = currentMonthSnap.data["image"];
            this.mother.week = pregnancy.weeks;
          }
          if (currentMonthSnap.connectionState == ConnectionState.waiting) {
            return CustomLoading();
          }
          return Container(
            width: double.infinity,
            child: Column(
              children: <Widget>[
                SizedBox(height: blockHeight * 1),
                buildMonthRow(),
                SizedBox(height: blockHeight * 2),
                ImageView(imageURL: this.mother.imageURL),
                SizedBox(height: blockHeight * 2.5),
                MotherWeek(this.widget.currentUser, this.mother),
                SizedBox(height: blockHeight * 2),
              ],
            ),
          );
        });
  }

  buildMonthRow() {
    return Container(
      height: blockHeight * 6,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 11,
        shrinkWrap: true,
        addAutomaticKeepAlives: false,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: (index != 0)
                ? Container(
                    margin: EdgeInsets.symmetric(horizontal: blockWidth * 3),
                    width: (_selectedIndex == index)
                        ? blockWidth * 12.5
                        : blockWidth * 7.5,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(100)),
                    child: Align(
                      alignment: Alignment.center,
                      child: (_selectedIndex == index)
                          ? Container(
                              decoration: BoxDecoration(
                                color: Colors.green[100],
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      index.toString(),
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: blockWidth * 4,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    // Text("Month",
                                    //     style: TextStyle(
                                    //       color: Colors.black87,
                                    //       fontSize: blockWidth * 2.5,
                                    //       fontWeight: FontWeight.w500,
                                    //     )),
                                  ],
                                ),
                              ),
                            )
                          : Text(
                              index.toString(),
                              style: TextStyle(
                                color: Colors.green[800],
                                fontSize: blockWidth * 4,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                    ),
                  )
                : Text(''),
            onTap: () => _onDaySelected(index),
          );
        },
      ),
    );
  }
}
