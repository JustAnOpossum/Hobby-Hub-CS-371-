import 'package:flutter/material.dart';
import 'package:hobby_hub/widgets/auth.dart';

import '../widgets/timer.dart';
import '../widgets/calendar.dart';
import '../theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hobby Hub',
      theme: myTheme,
      home: Home(),
    );
  }
}

//Main Home Page for hobby hub
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  static List<Widget> _widgetOptions = <Widget>[
    Text(
      'Demo Home Page',
    ),
    TimerPage(),
  ];

  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text(
          'Hobby Hub',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        actions: <Widget>[
          FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Logout'),
              onPressed: () async {
                await _auth.signOut();
              }),
          //Menu for the diffrent Menu options
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_currentIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: myTheme.primaryColor,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.lock_clock), label: 'Timer')
        ],
        onTap: _onItemTapped,
      ),
    );
  }
}
