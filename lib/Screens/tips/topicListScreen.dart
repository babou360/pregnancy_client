import 'package:flutter/material.dart';
import 'package:pregnancy_tracking_app/Screens/tips/topicView.dart';
import 'package:pregnancy_tracking_app/app/sizeConfig.dart';
import 'package:pregnancy_tracking_app/models/content.dart';
import 'package:pregnancy_tracking_app/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pregnancy_tracking_app/services/userDatabaseService.dart';
import 'package:pregnancy_tracking_app/widget/CustomBannerText.dart';
import 'package:pregnancy_tracking_app/widget/CustomIconButton.dart';
import 'package:pregnancy_tracking_app/widget/CustomLoading.dart';

class TopicListScreen extends StatefulWidget {
  User1 currentUser;
  TopicListScreen(this.currentUser);

  @override
  _TopicListScreenState createState() => _TopicListScreenState();
}

class _TopicListScreenState extends State<TopicListScreen> {
  double blockHeight = SizeConfig.safeBlockVertical;
  double blockWidth = SizeConfig.safeBlockHorizontal;
  Stream topicStream;
  UserDatabaseService _userDatabaseService = UserDatabaseService();

  @override
  void initState() {
    topicStream = _userDatabaseService.getTopics();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height -
              MediaQuery.of(context).size.height * 0.20,
          child: buildTopicList(),
        ),
      ],
    );
  }

  buildTopicList() {
    return StreamBuilder<QuerySnapshot>(
      stream: topicStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return CustomLoading();
        }
        return ListView(
          children: snapshot.data.docs.map((document) {
            Content mainTopic = Content();
            //mainTopic.id = document["id"];
            mainTopic.title = document["title"];
            mainTopic.subtitle = document["subtitle"];
            mainTopic.description = document["description"];
            mainTopic.imageURL = document["image"];
            return GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        TopicView(mainTopic, this.widget.currentUser),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                    vertical: blockHeight * 0.4, horizontal: blockWidth * 2),
                width: double.infinity,
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: blockWidth * 3, vertical: blockHeight * 2),
                  decoration: BoxDecoration(
                    color: Colors.green[300].withOpacity(0),
                    border: Border.all(color: Colors.green),
                    borderRadius: BorderRadius.all(
                      Radius.circular(15.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        width: blockWidth * 65,
                        child: CustomBannerText(
                          fontFamily: 'Roboto',
                          color: Colors.grey[800],
                          title: mainTopic.title,
                          size: blockWidth * 4,
                          weight: FontWeight.w300,
                        ),
                      ),
                      CustomIconButton(
                          icon: Icons.arrow_forward_ios,
                          callback: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    TopicView(mainTopic, this.widget.currentUser),
                              ),
                            );
                          })
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
