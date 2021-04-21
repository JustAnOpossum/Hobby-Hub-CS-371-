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
    final hobbyState = Provider.of<CurrentHobby>(context);
    String _hobbyName = hobbyState.getHobby;

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
                      value: hobbyState.getHobby,
                      items: <String>['Hobby1', 'Hobby2', 'Hobby3']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      // Called when the user selects a new hobby
                      onChanged: (String tapped) {
                        setState(() {
                          hobbyState.updateHobby(tapped);
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
