import 'package:flutter/material.dart';
import 'package:pregnancy_tracking_app/Screens/profile/update/updatePersonalInfo.dart';
import 'package:pregnancy_tracking_app/widget/CustomCard.dart';
import 'package:pregnancy_tracking_app/app/sizeConfig.dart';
import 'package:pregnancy_tracking_app/models/user.dart';

class PersonalInfo extends StatefulWidget {
  User currentUser;
  PersonalInfo(this.currentUser);
  @override
  _PersonalInfoState createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  double blockHeight = SizeConfig.safeBlockVertical;
  double blockWidth = SizeConfig.safeBlockHorizontal;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      title: "Personal Informations",
      showIcon: true,
      updateWidget: UpdatePersonalInfo(this.widget.currentUser),
      cardBody: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                height: blockWidth * 35,
                width: blockWidth * 35,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green[300].withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 15,
                    ),
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                ),
                child: CircleAvatar(
                  backgroundImage: (this.widget.currentUser.profileImageURL !=
                          null)
                      ? NetworkImage(this.widget.currentUser.profileImageURL)
                      : AssetImage("images/defaultProfile.png"),
                ),
              ),
              SizedBox(width: blockHeight * 2),
              Container(
                width: blockWidth * 45,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      this.widget.currentUser.name,
                      softWrap: true,
                      style: TextStyle(
                          fontSize: blockWidth * 4.5,
                          fontWeight: FontWeight.w300,
                          color: Colors.black87),
                    ),
                    SizedBox(height: blockHeight * 0.5),
                    Text(
                      this.widget.currentUser.mobileNumber,
                      style: TextStyle(
                        fontSize: blockWidth * 4,
                        fontWeight: FontWeight.w300,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: blockHeight * 0.5),
                    Text(
                      this.widget.currentUser.age.toString() + " Years old",
                      style: TextStyle(
                        fontSize: blockWidth * 4,
                        fontWeight: FontWeight.w300,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: blockHeight * 1),
        ],
      ),
    );
  }
}
