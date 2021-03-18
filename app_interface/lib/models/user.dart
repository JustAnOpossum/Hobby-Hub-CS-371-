import 'package:flutter/foundation.dart';

class User {
  int usernum;
  final String userName;
  final String firstName;
  final String lastName;
  final String password;
  final String email;
  final DateTime dateJoined;

  User({
    this.usernum = 0,
    @required this.userName,
    @required this.firstName,
    @required this.lastName,
    @required this.password,
    @required this.email,
    @required this.dateJoined,
  });
}
