import 'package:cloud_firestore/cloud_firestore.dart';

class UserDatabaseService {
  final firestoreInstance = Firestore.instance;

  Stream<dynamic> getBabyWeek(int week) {
    return firestoreInstance
        .collection("baby")
        .document(week.toString())
        .collection("data")
        // .collection("babyWeek")
        // .document("week" + week.toString())
        .snapshots();
  }

  // Future<List<DocumentSnapshot>> baby1(String week) async {
    Future<dynamic> baby1(int week) async {
    var data = await Firestore.instance
        .collection('baby')
        .document(week.toString())
        .collection('data')
        .orderBy('date',descending: true)
        .getDocuments();
    var all = data.documents;
    return all;
    // var productId = data.documents;
    // return productId;
  }

   Future<dynamic> getMomMonth(int month) async {
    var data = await Firestore.instance
        .collection('mother')
        .document(month.toString())
        .collection('data')
        .orderBy('date',descending: true)
        .getDocuments();
    var all = data.documents;
    return all;
    // var productId = data.documents;
    // return productId;
  }

  Stream<dynamic> getMomWeek(int week) {
    return firestoreInstance
        .collection("momsInWeek")
        .document("week" + week.toString())
        .snapshots();
  }

  // Stream<dynamic> getMomMonth(int month) {
  //   return firestoreInstance
  //       // .collection("momsInMonth")
  //       // .document("month" + month.toString())
  //       .collection("mother")
  //       .document(month.toString())
  //       .collection('data')
  //       .orderBy('date',descending: true)
  //       .snapshots();
  // }

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
