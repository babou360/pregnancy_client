import 'package:flutter/material.dart';
import 'package:pregnancy_tracking_app/app/sizeConfig.dart';
import 'package:pregnancy_tracking_app/widget/CustomIconButton.dart';

class CustomCard extends StatefulWidget {
  Widget cardBody, updateWidget;
  String title;
  bool showIcon;
  CustomCard({
    @required this.title,
    @required this.cardBody,
    @required this.updateWidget,
    @required this.showIcon,
  });
  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  double blockHeight = SizeConfig.safeBlockVertical;
  double blockWidth = SizeConfig.safeBlockHorizontal;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: blockWidth * 2, vertical: blockHeight * 1),
      width: double.infinity,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: blockWidth * 4, vertical: blockHeight * 1),
            decoration: BoxDecoration(
          color: Colors.green[300].withOpacity(0),
          border: Border.all(color: Colors.green),
          borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        // decoration: BoxDecoration(
        //   color: Colors.green[600].withOpacity(.9),
        //   // color: Colors.lightGreen[100].withOpacity(0.7),
        //   borderRadius: BorderRadius.all(
        //     Radius.circular(15.0),
        //   ),
        // ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  this.widget.title,
                  style: TextStyle(
                    fontFamily: '',
                    fontWeight: FontWeight.w400,
                    fontSize: blockWidth * 5,
                    color: Colors.grey[800],
                  ),
                ),
                (this.widget.showIcon == true)
                    ? CustomIconButton(
                        icon: Icons.edit,
                        callback: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return this.widget.updateWidget;
                            },
                          );
                        },
                      )
                    : Container(),
              ],
            ),
            this.widget.cardBody,
          ],
        ),
      ),
    );
  }
}
