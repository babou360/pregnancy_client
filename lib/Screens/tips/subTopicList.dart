import 'package:flutter/material.dart';
import 'package:pregnancy_tracking_app/Screens/tips/subTopicView.dart';
import 'package:pregnancy_tracking_app/models/subContent.dart';
import 'package:pregnancy_tracking_app/services/userDatabaseService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pregnancy_tracking_app/widget/CustomLoading.dart';

class SubTopicList extends StatefulWidget {
  String mainTopicId;
  SubTopicList(this.mainTopicId);
  @override
  _SubTopicListState createState() => _SubTopicListState();
}

class _SubTopicListState extends State<SubTopicList> {
  Stream topicStream;
  UserDatabaseService _userDatabaseService = UserDatabaseService();
  SubContent subTopic = SubContent();

  @override
  void initState() {
    topicStream = _userDatabaseService.getSubTopics(this.widget.mainTopicId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: topicStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CustomLoading();
        }
        return ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: snapshot.data.docs.map((document) {
            subTopic.id = document["id"];
            subTopic.title = document["title"];
            subTopic.description = document["description"];
            print(subTopic.title);
            return SubTopicView(subTopic);
          }).toList(),
        );
      },
    );
  }
}
