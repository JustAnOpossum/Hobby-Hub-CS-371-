import 'package:flutter/material.dart';

import '../models/user.dart';

class UserList extends StatelessWidget {
  final List<User> users;
  UserList(this.users);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: users.map((tx) {
        return Card(
            child: Row(
          children: <Widget>[
            Container(
              child: Text("Register as User: "),
            ),
            Column(
              children: <Widget>[
                Text(tx.userName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black,
                    )),
                Text(tx.firstName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black,
                    )),
                Text(tx.lastName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black,
                    )),
                Text(tx.email,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black,
                    )),
                Text(tx.password,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black,
                    )),
                // Text(tx.title,
                //   style: TextStyle(
                //     fontWeight: FontWeight.bold,
                //     fontSize: 16,
                //     color: Colors.black,
                //   )),
              ],
            )
          ],
        ));
      }).toList(),
    );
  }
}
