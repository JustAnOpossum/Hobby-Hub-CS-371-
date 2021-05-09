import 'package:flutter/material.dart';
import 'package:hobby_hub/models/person.dart';
import 'package:hobby_hub/widgets/user_list.dart';

import '../models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> updateUserData(
      String displayName, String email, List calendarEvents) async {
    return await userCollection
        .where('email', isEqualTo: email)
        .where('displayName', isEqualTo: displayName)
        .get()
        .then((value) => {
              value.docs.forEach((element) {
                userCollection.doc(element.id).update({
                  'calendarEvents': calendarEvents,
                });
              })
            });
  }

  Future<List> getUserData(String hobbyName) async {
    return userCollection
        .where('email', isEqualTo: 'EMAIL')
        .where('displayName', isEqualTo: 'NAME')
        .get()
        .then((value) {
      if (value.docs.length == 0) {
        userCollection.doc(uid).set({
          'displayName': 'NAME',
          'email': 'EMAIL',
          'calendarEvents': [],
        });
        return [];
      } else {
        return value.docs[0].data()['calendarEvents'];
      }
    });
  }

  List<Person> _userListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      //print(doc.data);
      return Person(
        email: doc.data()['email'] ?? '',
        displayName: doc.data()['displayName'] ?? '',
        calendarEvents: doc.data()['calendarEvents'] ?? [],
      );
    }).toList();
  }

  // user data from snapshots
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      email: snapshot.data()['email'],
      displayName: snapshot.data()['displayName'],
      calendarEvents: snapshot.data()['calendarEvents'],
    );
  }

  // get user stream
  Stream<List<Person>> get users {
    return userCollection.snapshots().map(_userListFromSnapshot);
  }

  // get user doc stream
  Stream<UserData> get userData {
    return userCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
