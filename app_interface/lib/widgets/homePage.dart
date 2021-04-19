import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _currentHobby = "Hobby1";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.check_circle),
                  title: Text('Select Hobby'),
                  subtitle: Text(
                      'Choose what hobby you are working on.\nYou are currently working on $_currentHobby'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    DropdownButton(
                      value: _currentHobby,
                      items: <String>['Hobby1', 'Hobby2', 'Hobby3']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String tapped) {
                        setState(() {
                          _currentHobby = tapped;
                        });
                      },
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
