import 'package:flutter/material.dart';
import 'package:pregnancy_tracking_app/app/sizeConfig.dart';

class TipContainer extends StatefulWidget {
  String callFrom;
  String description;
  int timeSlot;
  TipContainer(this.callFrom, this.description, this.timeSlot);

  @override
  _TipContainerState createState() => _TipContainerState();
}

class _TipContainerState extends State<TipContainer> {
  double blockHeight = SizeConfig.safeBlockVertical;
  double blockWidth = SizeConfig.safeBlockHorizontal;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: blockWidth * 3),
      width: double.infinity,
      child: Container(
        padding: EdgeInsets.all(blockWidth * 5),
        decoration: BoxDecoration(
          color: Colors.lightGreen[100].withOpacity(0.7),
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                getCardTitle(this.widget.callFrom),
                SizedBox(width: blockWidth * 5),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: blockWidth * 5, vertical: blockHeight * 0.5),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.2),
                    borderRadius: BorderRadius.all(
                      Radius.circular(50.0),
                    ),
                  ),
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: (this.widget.callFrom == "fromBaby")
                              ? "Week "
                              : "Month ",
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: blockWidth * 4,
                            color: Colors.green[900],
                          ),
                        ),
                        TextSpan(
                          text: this.widget.timeSlot.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: blockWidth * 6,
                            color: Colors.green[900],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: blockHeight * 2.5),
            Text(
              this.widget.description,
              style: TextStyle(
                  fontSize: blockWidth * 4.5, fontWeight: FontWeight.w300),
            ),
          ],
        ),
      ),
    );
  }

  getCardTitle(String callFrom) {
    String title;
    switch (callFrom) {
      case 'fromBaby':
        title = "Baby`s Development ";
        break;
      case 'fromMom':
        title = "Mother`s Development ";
        break;
      default:
    }
    return Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: blockWidth * 4.5,
        color: Colors.red[900],
      ),
    );
  }
}
