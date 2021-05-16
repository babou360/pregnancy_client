import 'package:flutter/material.dart';
import 'package:pregnancy_tracking_app/app/sizeConfig.dart';
import 'package:pregnancy_tracking_app/models/user.dart';
import 'package:pregnancy_tracking_app/services/databaseService.dart';
import 'package:pregnancy_tracking_app/widget/CustomBannerText.dart';
import 'package:pregnancy_tracking_app/widget/CustomButton.dart';

class UpdatePregInfo extends StatefulWidget {
  User1 currentUser;
  UpdatePregInfo(this.currentUser);
  @override
  _UpdatePregInfoState createState() => _UpdatePregInfoState();
}

class _UpdatePregInfoState extends State<UpdatePregInfo> {
  double blockHeight = SizeConfig.safeBlockVertical;
  double blockWidth = SizeConfig.safeBlockHorizontal;
  DatabaseService _databaseService = DatabaseService();

  DateTime currentDueDate;
  DateTime lastPeriodDate;
  DateTime pickedDate;
  bool _isDateSelect = false;
  String _errorText = '';

  onClickCancel() {
    Navigator.of(context).pop();
  }

  onClickSave() {
    if (pickedDate == null) {
      setState(() {
        _errorText = 'Please enter valid Date';
      });
    } else {
      this.widget.currentUser.lastPeriodDate = this.pickedDate;
      this._databaseService.createUser(this.widget.currentUser, false);

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    currentDueDate = this.widget.currentUser.dueDate;
    lastPeriodDate = this.widget.currentUser.lastPeriodDate;
    return AlertDialog(
      scrollable: true,
      backgroundColor: Colors.lightGreen[50],
      content: Container(
        child: Column(
          children: <Widget>[
            CustomBannerText(
              title: "Pregnancy Informations",
              size: blockWidth * 5,
              weight: FontWeight.w300,
            ),
            SizedBox(height: blockHeight * 4),
            InkWell(
              onTap: () {
                setState(() {
                  _pickDate(context, this.currentDueDate, this.lastPeriodDate);
                });
              },
              child: Container(
                height: blockHeight * 7.5,
                width: double.infinity,
                child: SizedBox(
                  width: double.infinity,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    elevation: 0,
                    color: Colors.green[100],
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: blockWidth * 5),
                          child: Icon(
                            Icons.calendar_today,
                            color: Colors.black54,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: blockWidth * 5),
                          child: Text(
                            () {
                              if (!_isDateSelect) {
                                return currentDueDate.year.toString() +
                                    " - " +
                                    currentDueDate.month.toString() +
                                    " - " +
                                    currentDueDate.day.toString();
                              } else {
                                return pickedDate.year.toString() +
                                    " - " +
                                    pickedDate.month.toString() +
                                    " - " +
                                    pickedDate.day.toString();
                              }
                            }(),
                            style: TextStyle(
                              fontSize: blockWidth * 4,
                              fontWeight: FontWeight.w400,
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
              style:
                  TextStyle(fontSize: blockWidth * 2, color: Colors.red[700]),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                CustomButton(
                  title: "Cancel",
                  bgColor: Colors.red[400].withOpacity(0.9),
                  textColor: Colors.white,
                  callback: onClickCancel,
                  width: blockWidth * 22.5,
                  height: blockHeight * 5,
                  fontSize: blockHeight * 2,
                ),
                CustomButton(
                  title: "Save",
                  bgColor: Colors.green[600],
                  textColor: Colors.white,
                  callback: onClickSave,
                  width: blockWidth * 22.5,
                  height: blockHeight * 5,
                  fontSize: blockHeight * 2,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<Null> _pickDate(BuildContext context, DateTime curretnDueDate,
      DateTime lastPeriodDate) async {
    DateTime _date = await showDatePicker(
      context: context,
      initialDate: curretnDueDate,
      firstDate: DateTime(
          curretnDueDate.year, currentDueDate.month - 2, currentDueDate.day),
      lastDate: DateTime(
          curretnDueDate.year, currentDueDate.month + 1, currentDueDate.day),
    );

    if (_date != null) {
      setState(() {
        _isDateSelect = true;
        _errorText = '';
        pickedDate = (_date.toUtc().toLocal());
      });
    }
  }
}

