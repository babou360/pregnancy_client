import 'package:flutter/material.dart';
import 'package:pregnancy_tracking_app/Screens/profile/update/updatePregInfo.dart';
import 'package:pregnancy_tracking_app/widget/CustomCard.dart';
import 'package:pregnancy_tracking_app/app/sizeConfig.dart';
import 'package:pregnancy_tracking_app/models/pregnancy.dart';
import 'package:pregnancy_tracking_app/models/user.dart';
import 'package:intl/intl.dart';

class PregnancyInfo extends StatefulWidget {
  User1 currentUser;
  PregnancyInfo(this.currentUser);
  @override
  _PregnancyInfoState createState() => _PregnancyInfoState();
}

class _PregnancyInfoState extends State<PregnancyInfo> {
  double blockHeight = SizeConfig.safeBlockVertical;
  double blockWidth = SizeConfig.safeBlockHorizontal;
  Pregnancy pregnancy = Pregnancy();

  @override
  void initState() {
    super.initState();
    pregnancy.updateValue(this.widget.currentUser);
  }

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      title: "Taarifa Za Mimba",
      showIcon: false,
      updateWidget: UpdatePregInfo(this.widget.currentUser),
      cardBody: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          SizedBox(height: blockHeight * 2),
          RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: 'Wiki ',
                  style: TextStyle(
                    fontFamily: '',
                    fontWeight: FontWeight.w300,
                    fontSize: blockWidth * 5,
                    color: Colors.grey[800],
                  ),
                ),
                TextSpan(
                  text: ' ' +
                  '${pregnancy.weeks<=1 ?pregnancy.weeks:pregnancy.weeks-1}',
                  style: TextStyle(
                    fontFamily: '',
                    fontWeight: FontWeight.w400,
                    fontSize: blockWidth * 5,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15),
          RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: 'Kujifungua ',
                  style: TextStyle(
                    fontFamily: '',
                    fontWeight: FontWeight.w300,
                    fontSize: blockWidth * 5,
                    color: Colors.grey[800],
                  ),
                ),
                TextSpan(
                  text: (pregnancy.dueDays <= 0) ? 'ilikua ' : '',
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: blockWidth * 4.5,
                    color: Colors.grey[800],
                  ),
                ),
                TextSpan(
                  text: ' ' +
                  '${this.widget.currentUser.dueDate.day}/${this.widget.currentUser.dueDate.month}/${this.widget.currentUser.dueDate.year}',
                  style: TextStyle(
                    fontFamily: '',
                    fontWeight: FontWeight.w400,
                    fontSize: blockWidth * 5,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: blockHeight * 1.5),
          Row(
            children: <Widget>[
              Text(
                "Zimebaki   ",
                style: TextStyle(
                  fontFamily: '',
                  fontWeight: FontWeight.w300,
                  fontSize: blockWidth * 4,
                  color: Colors.grey[800],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                decoration: BoxDecoration(
                  // color: Colors.green.withOpacity(0.2),
                  borderRadius: BorderRadius.all(
                    Radius.circular(50.0),
                  ),
                ),
                child: RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      CustomTextSpan(
                        (pregnancy.dueDays == 1) ? "Siku " : " Siku ",
                        blockWidth * 4,
                        FontWeight.w300,
                      ),
                      CustomTextSpan(
                        pregnancy.dueDays.toString(),
                        blockWidth * 5,
                        FontWeight.w400,
                      ),
                      CustomTextSpan(
                        (pregnancy.dueWeeks != 0 && pregnancy.dueDays != 0)
                            ? " | "
                            : "",
                        blockWidth * 5,
                        FontWeight.w400,
                      ),
                      CustomTextSpan(
                        (pregnancy.dueWeeks == 1) ? "Wiki " : " Wiki ",
                        blockWidth * 4,
                        FontWeight.w300,
                      ),
                      CustomTextSpan(
                        pregnancy.dueWeeks.toString(),
                        blockWidth * 5,
                        FontWeight.w400,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: blockHeight * 2),
        ],
      ),
    );
  }

  CustomTextSpan(String title, double size, FontWeight weight) {
    return TextSpan(
      text: title,
      style: TextStyle(
        fontWeight: weight,
        fontFamily: '',
        fontSize: size,
        color: Colors.green
        // color: Colors.green[900],
      ),
    );
  }
}
