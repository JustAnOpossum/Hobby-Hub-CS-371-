import 'package:flutter/material.dart';

import '../models/user.dart';

class Login extends StatefulWidget {
  final List<User> _users = [
    User(
      userId: 'BobMan11',
      firstName: 'Robert',
      lastName: 'Manfield',
      password: 'iamreallycool2011',
      email: 'bobmanfield2011@email.com',
      dateJoined: DateTime.now(),
    )
  ];
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[NewUser(), UserList()],
    );
  }
}
