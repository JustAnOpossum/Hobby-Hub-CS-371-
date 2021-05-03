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

  Future<void> updateUserData(String displayName, String email) async {
    return await userCollection.doc(uid).set({
      'displayName': displayName,
      'email': email,
    });
  }

  List<Person> _userListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      //print(doc.data);
      return Person(
        email: doc.data()['email'] ?? '',
        displayName: doc.data()['displayName'] ?? '',
      );
    }).toList();
  }

  // user data from snapshots
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        email: snapshot.data()['email'],
        displayName: snapshot.data()['displayName']);
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
