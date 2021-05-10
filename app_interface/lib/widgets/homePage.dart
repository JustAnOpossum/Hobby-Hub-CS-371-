import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './hobbyClass.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final hobbyInfo = Provider.of<HobbyInfo>(context);
    String _hobbyName = hobbyInfo.getHobby;

    return Scaffold(
      body: Center(
          child: Column(
        children: [
          //Card for selecting the hobbies
          Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.check_circle),
                  title: Text('Select Hobby'),
                  subtitle: Text(
                      'Choose what hobby you are working on.\nYou are currently working on $_hobbyName'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    //Dropdown button to selected the actual hobby
                    DropdownButton(
                      value: hobbyInfo.getHobby,
                      items: hobbyInfo.getAllHobbies
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      // Called when the user selects a new hobby
                      onChanged: (String tapped) {
                        setState(() {
                          hobbyInfo.updateHobby(tapped);
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
