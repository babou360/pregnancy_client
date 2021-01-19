import 'package:flutter/material.dart';
import 'package:pregnancy_tracking_app/app/sizeConfig.dart';
import 'package:pregnancy_tracking_app/models/subContent.dart';
import 'package:pregnancy_tracking_app/widget/CustomBannerText.dart';

class SubTopicView extends StatelessWidget {
  SubContent subTopic;
  SubTopicView(this.subTopic);
  double blockHeight = SizeConfig.safeBlockVertical;
  double blockWidth = SizeConfig.safeBlockHorizontal;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: blockWidth * 2.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CustomBannerText(
            title: subTopic.title,
            size: blockWidth * 5,
            weight: FontWeight.w400,
            color: Colors.green[800],
          ),
          SizedBox(height: blockHeight * 2),
          CustomBannerText(
            title: subTopic.description,
            size: blockWidth * 4,
            weight: FontWeight.w400,
          ),
          SizedBox(height: blockHeight * 2),
        ],
      ),
    );
  }
}
