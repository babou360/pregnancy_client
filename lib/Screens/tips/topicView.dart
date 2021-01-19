import 'package:flutter/material.dart';
import 'package:pregnancy_tracking_app/Screens/tips/subTopicList.dart';
import 'package:pregnancy_tracking_app/app/sizeConfig.dart';
import 'package:pregnancy_tracking_app/models/content.dart';
import 'package:pregnancy_tracking_app/models/user.dart';
import 'package:pregnancy_tracking_app/widget/CustomBannerText.dart';
import 'package:pregnancy_tracking_app/widget/CustomIconButton.dart';
import 'package:pregnancy_tracking_app/widget/ImageView.dart';

class TopicView extends StatefulWidget {
  User currentUser = User();
  Content mainTopic = Content();
  TopicView(this.mainTopic, this.currentUser);

  @override
  _TopicViewState createState() => _TopicViewState();
}

class _TopicViewState extends State<TopicView> {
  double blockHeight = SizeConfig.safeBlockVertical;
  double blockWidth = SizeConfig.safeBlockHorizontal;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: blockHeight * 2,
                    horizontal: blockWidth * 4,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          CustomIconButton(
                              icon: Icons.arrow_back,
                              callback: () {
                                Navigator.pop(context);
                              })
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 5,
                            ),
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                        ),
                        child: CircleAvatar(
                          backgroundImage:
                              (this.widget.currentUser.profileImageURL == null)
                                  ? AssetImage("images/profile.jpg")
                                  : NetworkImage(
                                      this.widget.currentUser.profileImageURL,
                                    ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: blockWidth * 2.5,
                        ),
                        child: CustomBannerText(
                          title: this.widget.mainTopic.title,
                          size: blockWidth * 7,
                          weight: FontWeight.w600,
                          color: Colors.green[900],
                        ),
                      ),
                      SizedBox(height: blockHeight * 2),
                      ImageView(imageURL: this.widget.mainTopic.imageURL),
                      SizedBox(height: blockHeight * 2),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: blockWidth * 3,
                        ),
                        child: CustomBannerText(
                          title: this.widget.mainTopic.description,
                          size: blockWidth * 4.5,
                          weight: FontWeight.w400,
                          color: Colors.green[900],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: blockHeight * 1),
                Divider(
                  thickness: 1.0,
                  color: Colors.green[200],
                  indent: blockWidth * 3,
                  endIndent: blockWidth * 3,
                ),
                SizedBox(height: blockHeight * 1),
                Column(
                  children: <Widget>[
                    SubTopicList(this.widget.mainTopic.id),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
