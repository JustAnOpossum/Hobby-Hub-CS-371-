import 'package:flutter/foundation.dart';

class User {
  final String userId;
  final String firstName;
  final String lastName;
  final String password;
  final String email;
  final DateTime dateJoined;

  User({
    @required this.userId,
    @required this.firstName,
    @required this.lastName,
    @required this.password,
    @required this.email,
    @required this.dateJoined,
  });
}
