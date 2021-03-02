import 'dart:io';

import '../models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DatabaseService {
  final firestoreInstance = Firestore.instance;
  final storageInstance = FirebaseStorage.instance;

  createUser(User user, bool isNew) async {
    await firestoreInstance
        .collection('users')
        .document(user.mobileNumber)
        .setData(
      {
        'phoneNumber': user.mobileNumber,
        'name': user.name,
        'age': user.age,
        'profileImage': user.profileImageURL,
        'lastPeriodDate': user.lastPeriodDate,
        'weight': (user.weight != null) ? user.weight : 0.0,
        'bloodCount': (user.bloodCount != null) ? user.bloodCount : 0.0,
        'dueDate': user.dueDate,
        'payDate': DateTime.now(),
        'joinedAt': (isNew) ? DateTime.now() : user.joinedAt,
        'renewalDate': (user.renewalDate != null)
            ? user.renewalDate
            : DateTime.now().add(Duration(days: 30)),
      },
      merge: true,
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
        .document(docKey)
        .updateData({'profileImage': null}).then((value) {
      print("data updated");
    }).catchError((error) {
      print(error.toString());
    });
  }

  Future<bool> uploadImage(String filePath, File file, User currentUser) async {
    StorageReference storageReference = storageInstance.ref();
    StorageUploadTask uploadTask =
        storageReference.child(filePath).putFile(file);

    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    taskSnapshot.ref.getDownloadURL().then((downloadURL) {
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
  }

  Future deleteImage(String imageURL) async {
    print(imageURL);
    StorageReference storageRef =
        await storageInstance.getReferenceFromUrl(imageURL);
    try {
      await storageRef.delete();
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
        .document(documentKey)
        .snapshots();
  }

  void getSubscriptions(String userId) async {
    // TODO  get subscription details from database (users/subscriptions)
  }
}

