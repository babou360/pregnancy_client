import 'package:flutter/material.dart';
import 'package:pregnancy_tracking_app/Screens/profile/update/updatePregCalculation.dart';
import 'package:pregnancy_tracking_app/widget/CustomCard.dart';
import 'package:pregnancy_tracking_app/app/sizeConfig.dart';
import 'package:pregnancy_tracking_app/models/user.dart';
import 'package:pregnancy_tracking_app/widget/CustomBannerText.dart';

class PregnancyCalculation extends StatefulWidget {
  User currentUser;
  PregnancyCalculation(this.currentUser);
  @override
  _PregnancyCalculationState createState() => _PregnancyCalculationState();
}

class _PregnancyCalculationState extends State<PregnancyCalculation> {
  double blockHeight = SizeConfig.safeBlockVertical;
  double blockWidth = SizeConfig.safeBlockHorizontal;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      title: "Pregnancy Calculatios",
      showIcon: true,
      updateWidget: UpdatePregCalculation(this.widget.currentUser),
      cardBody: Column(
        children: [
          SizedBox(height: blockHeight * 2),
          Container(
            child: (this.widget.currentUser.bloodCount == 0.0 &&
                    this.widget.currentUser.weight == 0.0)
                ? CustomBannerText(
                    title:
                        "Update your weight and blood count for better informations",
                    size: blockWidth * 5,
                    weight: FontWeight.w700,
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CustomBannerText(title: "Weight"),
                          SizedBox(height: blockHeight * 1),
                          Row(
                            children: <Widget>[
                              CustomBannerText(
                                title:
                                    this.widget.currentUser.weight.toString(),
                                size: blockWidth * 10,
                              ),
                              CustomBannerText(
                                title: "  Kg",
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: blockHeight * 1),
                        child: VerticalDivider(
                          color: Colors.green[700],
                          width: blockWidth * 2,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CustomBannerText(title: "Blood Count"),
                          SizedBox(height: blockHeight * 1),
                          Row(
                            children: <Widget>[
                              CustomBannerText(
                                title: this
                                    .widget
                                    .currentUser
                                    .bloodCount
                                    .toString(),
                                size: blockWidth * 10,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

