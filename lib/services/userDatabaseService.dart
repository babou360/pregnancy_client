import 'package:cloud_firestore/cloud_firestore.dart';

class UserDatabaseService {
  final firestoreInstance = FirebaseFirestore.instance;

  Stream<dynamic> getBabyWeek(int week) {
    return firestoreInstance
        .collection("baby")
        .doc(week.toString())
        .collection("data")
        // .collection("babyWeek")
        // .document("week" + week.toString())
        .snapshots();
  }

  // Future<List<DocumentSnapshot>> baby1(String week) async {
    Future<dynamic> baby1(int week) async {
    var data = await FirebaseFirestore.instance
        .collection('baby')
        .doc(week.toString())
        .collection('data')
        .orderBy('date',descending: true)
        .get();
    var all = data.docs;
    return all;
    // var productId = data.documents;
    // return productId;
  }

   Future<dynamic> getMomMonth(int month) async {
    var data = await FirebaseFirestore.instance
        .collection('mother')
        .doc(month.toString())
        .collection('data')
        .orderBy('date',descending: true)
        .get();
    var all = data.docs;
    return all;
    // var productId = data.documents;
    // return productId;
  }

  Stream<dynamic> getMomWeek(int week) {
    return firestoreInstance
        .collection("momsInWeek")
        .doc("week" + week.toString())
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
        .doc(mainTopicId)
        .collection("subTopics")
        .snapshots();
  }
}
