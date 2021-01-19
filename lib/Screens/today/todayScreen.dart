import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:pregnancy_tracking_app/app/sizeConfig.dart';
import 'package:pregnancy_tracking_app/models/pregnancy.dart';
import 'package:pregnancy_tracking_app/models/user.dart';
import 'package:intl/intl.dart';
import 'package:pregnancy_tracking_app/widget/CustomBannerText.dart';

class TodayScreen extends StatefulWidget {
  User currentUser;
  TodayScreen(this.currentUser);
  @override
  _TodayScreenState createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
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
    return Container(
      color: Colors.lightGreen[00],
      width: double.infinity,
      child: Column(
        children: <Widget>[
          SizedBox(height: blockHeight * 1),
          buildPercentageBar(),
          SizedBox(height: blockHeight * 1),
          SizedBox(height: blockHeight * 2.5),
          buildCountRow(),
          SizedBox(height: blockHeight * 1),
          buildDueRow(),
        ],
      ),
    );
  }

  buildPercentageBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: blockWidth * 3),
      child: LinearPercentIndicator(
        animation: true,
        lineHeight: blockHeight * 5,
        animationDuration: 2500,
        percent: pregnancy.days / 280,
        center: RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: 'You are ',
                style: TextStyle(
                    fontWeight: FontWeight.w300, fontSize: blockWidth * 4),
              ),
              TextSpan(
                text: (pregnancy.days >= 7)
                    ? (pregnancy.days / 7).toInt().toString()
                    : '',
                style: TextStyle(
                    fontWeight: FontWeight.w500, fontSize: blockWidth * 5),
              ),
              TextSpan(
                text: (pregnancy.days >= 7)
                    ? (pregnancy.days >= 7 && pregnancy.days <= 13)
                        ? ' week '
                        : ' weeks '
                    : '',
                style: TextStyle(
                    fontWeight: FontWeight.w500, fontSize: blockWidth * 4),
              ),
              TextSpan(
                text: ((pregnancy.days % 7 != 0) && (pregnancy.days >= 7))
                    ? '& '
                    : ' ',
                style: TextStyle(
                    fontWeight: FontWeight.w300, fontSize: blockWidth * 4),
              ),
              TextSpan(
                text: (pregnancy.days % 7 != 0)
                    ? (pregnancy.days % 7).toString()
                    : '',
                style: TextStyle(
                    fontWeight: FontWeight.w500, fontSize: blockWidth * 5),
              ),
              TextSpan(
                text: (pregnancy.days % 7 != 0)
                    ? (pregnancy.days % 7 == 1)
                        ? ' day '
                        : ' days '
                    : '',
                style: TextStyle(
                    fontWeight: FontWeight.w500, fontSize: blockWidth * 4),
              ),
              TextSpan(
                text: 'pregnant ',
                style: TextStyle(
                    fontWeight: FontWeight.w300, fontSize: blockWidth * 4),
              ),
            ],
          ),
        ),
        linearStrokeCap: LinearStrokeCap.roundAll,
        progressColor: Colors.red[400],
        backgroundColor: Colors.red[200],
        curve: Curves.easeInOut,
      ),
    );
  }

  buildCountRow() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: blockWidth * 3),
      height: blockHeight * 15,
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.lightGreen[100].withOpacity(0.7),
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CustomBannerText(title: "Day"),
                CustomBannerText(
                  title: pregnancy.days.toString(),
                  size: blockWidth * 12,
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: blockHeight * 2),
              child: VerticalDivider(
                color: Colors.green[700],
                width: blockWidth * 2,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CustomBannerText(title: "Week"),
                CustomBannerText(
                  title: pregnancy.weeks.toString(),
                  size: blockWidth * 12,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: blockHeight * 2),
              child: VerticalDivider(
                color: Colors.green[700],
                width: blockWidth * 2,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CustomBannerText(title: "Month"),
                CustomBannerText(
                  title: pregnancy.months.toString(),
                  size: blockWidth * 12,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  buildDueRow() {
    return Container(
      margin: EdgeInsets.only(top: blockHeight * 1),
      padding: EdgeInsets.symmetric(horizontal: blockWidth * 3),
      height: blockHeight * 13,
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.lightGreen[100],
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Due date ',
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: blockWidth * 5,
                          color: Colors.black54,
                        ),
                      ),
                      TextSpan(
                        text: (pregnancy.dueDays <= 0) ? 'was ' : '',
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: blockWidth * 5,
                          color: Colors.black54,
                        ),
                      ),
                      TextSpan(
                        text: ' ' +
                            DateFormat('EEE, d MMM yyyy')
                                .format(this.widget.currentUser.dueDate)
                                .toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: blockWidth * 6,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: blockHeight),
                RichText(
                  text: (pregnancy.dueDays > 0)
                      ? TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: (pregnancy.dueDays >= 7)
                                  ? (pregnancy.dueDays / 7).toInt().toString()
                                  : '',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: blockWidth * 6,
                                  color: Colors.green[700]),
                            ),
                            TextSpan(
                              text: (pregnancy.dueDays >= 7)
                                  ? (pregnancy.dueDays >= 7 &&
                                          pregnancy.dueDays <= 13)
                                      ? ' week '
                                      : ' weeks '
                                  : '',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: blockWidth * 5,
                                  color: Colors.green[700]),
                            ),
                            TextSpan(
                              text: ((pregnancy.dueDays % 7 != 0) &&
                                      (pregnancy.dueDays >= 7))
                                  ? '& '
                                  : '',
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                color: Colors.green[700],
                                fontSize: blockWidth * 5,
                              ),
                            ),
                            TextSpan(
                              text: (pregnancy.dueDays % 7 != 0)
                                  ? (pregnancy.dueDays % 7).toString()
                                  : '',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: blockWidth * 6,
                                  color: Colors.green[700]),
                            ),
                            TextSpan(
                              text: (pregnancy.dueDays % 7 != 0)
                                  ? (pregnancy.dueDays % 7 == 1)
                                      ? ' day '
                                      : ' days '
                                  : '',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: blockWidth * 5,
                                  color: Colors.green[700]),
                            ),
                            TextSpan(
                              text: 'left ',
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                color: Colors.green[700],
                                fontSize: blockWidth * 5,
                              ),
                            ),
                          ],
                        )
                      : TextSpan(
                          text: 'You will delivery soon',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: blockWidth * 5,
                            color: Colors.green[700],
                          ),
                        ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
