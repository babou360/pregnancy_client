import 'package:flutter/material.dart';
import 'package:pregnancy_tracking_app/models/motherModel.dart';
import 'package:pregnancy_tracking_app/models/pregnancy.dart';
import 'package:pregnancy_tracking_app/models/user.dart';
import 'package:pregnancy_tracking_app/services/userDatabaseService.dart';
import 'package:pregnancy_tracking_app/widget/tipContainer.dart';

class MotherWeek extends StatefulWidget {
  User currentUser;
  Mother mother;
  MotherWeek(this.currentUser, this.mother);
  @override
  _MotherWeekState createState() => _MotherWeekState();
}

class _MotherWeekState extends State<MotherWeek> {
  Pregnancy pregnancy = Pregnancy();
  UserDatabaseService _userDatabaseService = UserDatabaseService();
  Stream motherWeekStram;

  @override
  void initState() {
    super.initState();
    pregnancy.updateValue(this.widget.currentUser);
    motherWeekStram = _userDatabaseService.getMomWeek(this.widget.mother.week);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: motherWeekStram,
      builder: (context, currentWeekSnap) {
        if (currentWeekSnap.hasData && currentWeekSnap.data.exists) {
          this.widget.mother.tipDescription =
              currentWeekSnap.data["tipDescription"];
        }
        if (currentWeekSnap.connectionState == ConnectionState.waiting) {
          return Container(
            child: Column(
              children: <Widget>[
                SizedBox(height: 10.0),
                Container(
                  margin:
                      EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
                  height: 250.0,
                  width: double.infinity,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              ],
            ),
          );
        }
        return TipContainer("fromMom", this.widget.mother.tipDescription,
            this.widget.mother.week);
      },
    );
  }
}
