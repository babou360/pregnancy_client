import 'package:cloud_firestore/cloud_firestore.dart';

class UserDatabaseService {
  final firestoreInstance = Firestore.instance;

  Stream<dynamic> getBabyWeek(int week) {
    return firestoreInstance
        .collection("baby")
        .document(week.toString())
        // .collection("babyWeek")
        // .document("week" + week.toString())
        .snapshots();
  }

  Stream<dynamic> getMomWeek(int week) {
    return firestoreInstance
        .collection("momsInWeek")
        .document("week" + week.toString())
        .snapshots();
  }

  Stream<dynamic> getMomMonth(int month) {
    return firestoreInstance
        // .collection("momsInMonth")
        // .document("month" + month.toString())
        .collection("mother")
        .document(month.toString())
        .snapshots();
  }

  Stream<dynamic> getTopics() {
    return firestoreInstance.collection("tips").snapshots();
  }

  Stream<dynamic> getSubTopics(String mainTopicId) {
    return firestoreInstance
        .collection("tips")
        .document(mainTopicId)
        .collection("subTopics")
        .snapshots();
  }
}

