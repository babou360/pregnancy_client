import 'package:flutter/material.dart';
import 'package:pregnancy_tracking_app/app/sizeConfig.dart';
import 'package:pregnancy_tracking_app/widget/CustomBannerText.dart';
import 'package:pregnancy_tracking_app/widget/CustomCard.dart';
import 'package:pregnancy_tracking_app/models/user.dart';

class PaymentInfo extends StatefulWidget {
  User currentUser;
  PaymentInfo(this.currentUser);
  @override
  _PaymentInfoState createState() => _PaymentInfoState();
}

class _PaymentInfoState extends State<PaymentInfo> {
  double blockHeight = SizeConfig.safeBlockVertical;
  double blockWidth = SizeConfig.safeBlockHorizontal;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      title: "Payment Informations",
      showIcon: true,
      updateWidget: null,
      cardBody: Container(
          child: Column(
        children: [
          SizedBox(height: blockHeight * 3),
          CustomBannerText(
            title: "Payment 1 on 2020-08-08",
            size: blockWidth * 5,
          ),
          SizedBox(height: blockHeight * 1),
          CustomBannerText(
            title: "Payment 2 on 2020-09-16",
            size: blockWidth * 5,
          ),
          SizedBox(height: blockHeight * 1),
          CustomBannerText(
            title: "Payment 3 on 2020-10-20",
            size: blockWidth * 5,
          ),
        ],
      )),
    );
  }
}
