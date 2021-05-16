import 'dart:io';

import '../models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DatabaseService {
  final firestoreInstance = FirebaseFirestore.instance;
  final storageInstance = FirebaseStorage.instance;

  createUser(User1 user, bool isNew) async {
    await firestoreInstance
        .collection('users')
        .doc(user.mobileNumber)
        .set(
      {
        'phoneNumber': user.mobileNumber,
        'name': user.name,
        'age': user.age,
        'profileImage': user.profileImageURL,
        'lastPeriodDate': user.lastPeriodDate,
        'weight': (user.weight != null) ? user.weight : 0.0,
        'bloodCount': (user.bloodCount != null) ? user.bloodCount : 0.0,
        'dueDate': user.dueDate,
        'payDate':(isNew) ? DateTime.now() : user.payDate,
        // 'payDate': DateTime.now(),
        'joinedAt': (isNew) ? DateTime.now() : user.joinedAt,
        'renewalDate': (user.renewalDate != null)
            ? user.renewalDate
            : DateTime.now().add(Duration(days: 30)),
      },
      // merge: true,
    ).then((value) {
      if (!isNew) {
        print("data update seccessfully");
      }
    }).catchError((error) {
      print(error.toString());
    });
  }

  updateWhenDeleteImage(String docKey) async {
    await firestoreInstance
        .collection('users')
        .doc(docKey)
        .update({'profileImage': null}).then((value) {
      print("data updated");
    }).catchError((error) {
      print(error.toString());
    });
  }

  Future<bool> uploadImage(String filePath, File file, User1 currentUser) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref();
    //StorageReference storageReference = storageInstance.ref();
    UploadTask  uploadTask = ref.child(filePath).putFile(file);
    uploadTask.then((res) {
      res.ref.getDownloadURL().then((downloadURL) {
      print(currentUser.name);
      print(currentUser.age);
      currentUser.profileImageURL = downloadURL;
      createUser(currentUser, false);
    }).then((value) {
      print("image upload success");
    }).catchError((error) {
      print("error while uploading");
      print(error);
    });
    });

    // StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    // taskSnapshot.ref.getDownloadURL().then((downloadURL) {
    //   print(currentUser.name);
    //   print(currentUser.age);
    //   currentUser.profileImageURL = downloadURL;
    //   createUser(currentUser, false);
    // }).then((value) {
    //   print("image upload success");
    // }).catchError((error) {
    //   print("error while uploading");
    //   print(error);
    // });
  }

  Future deleteImage(String imageURL) async {
    print(imageURL);
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref();
    ref= storage.refFromURL(imageURL);
    // StorageReference storageRef =
    //     await storageInstance.getReferenceFromUrl(imageURL);
    try {
      await ref.delete();
      print("image deleted success");
      return true;
    } catch (e) {
      print(e.toString());
      print("error on image delete");
      return false;
    }
  }

  Stream<dynamic> getUser(String documentKey) {
    return firestoreInstance
        .collection('users')
        .doc(documentKey)
        .snapshots();
  }

  void getSubscriptions(String userId) async {
    // TODO  get subscription details from database (users/subscriptions)
  }
}

