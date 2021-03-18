import 'package:flutter/material.dart';

class NewUser extends StatelessWidget {
  final userNameController = TextEditingController();
  final fNameController = TextEditingController();
  final lNameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final passCheckController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Username: '),
                controller: userNameController,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'First name: '),
                controller: fNameController,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Last name: '),
                controller: lNameController,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Email: '),
                controller: emailController,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Password: '),
                controller: passwordController,
              ),
              TextField(
                decoration:
                    InputDecoration(labelText: 'Confirm Your Password: '),
                controller: passwordController,
              ),
              FlatButton(
                  child: Text('Create Account'),
                  textColor: Colors.blue,
                  onPressed: () {})
            ]),
      ),
    );
  }
}
