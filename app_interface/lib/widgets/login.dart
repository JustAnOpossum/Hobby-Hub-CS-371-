import 'package:flutter/material.dart';

import '../models/user.dart';
import 'newUser.dart';
import 'userList.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final List<User> _users = [
    User(
      userName: 'BobMan11',
      firstName: 'Robert',
      lastName: 'Manfield',
      password: 'iamreallycool2011',
      email: 'bobmanfield2011@email.com',
      dateJoined: DateTime.now(),
    ),
    User(
      userName: 'SillyBilly05',
      firstName: 'Bill',
      lastName: 'Sillsville',
      password: 'sillygeese',
      email: 'sillygooseville@email.com',
      dateJoined: DateTime.now(),
    )
  ];

  void _addNewUser(String txUserName, String txFName, String txLName,
      String txEmail, String txPassword) {
    final newTx = User(
      userName: txUserName,
      firstName: txFName,
      lastName: txLName,
      email: txEmail,
      password: txPassword,
      usernum: 1,
      dateJoined: DateTime.now(),
    );

    setState(() {
      _users.add(newTx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[NewUser(_addNewUser), UserList(_users)],
    );
  }
}
