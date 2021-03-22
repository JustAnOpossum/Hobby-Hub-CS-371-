import 'package:flutter/material.dart';

import './widgets/login.dart';
import './widgets/timer.dart';
import './widgets/calendar.dart';

void main() {
  runApp(MyApp());
}

var myTheme =
    ThemeData(primaryColor: Color(0xFFAF5D63), accentColor: Color(0xFFD5896F));

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Hobby Hub',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      //Menu for the diffrent Menu options
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            //Hobby List Page
            ListTile(
              leading: Icon(Icons.list),
              title: Text('Hobby List'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return Scaffold(
                    appBar: AppBar(
                      title: const Text('Hobby List'),
                    ),
                    body: const Center(
                      child: Text('Demo Home Page for Hobby Hub Hobby List',
                          style: TextStyle(fontSize: 30)),
                    ),
                  );
                }));
              },
            ),
            //Timer Page
            ListTile(
              leading: Icon(Icons.access_time),
              title: Text('Timer'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TimerPage()));
              },
            ),
            //Calendar Page
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text('Calendar'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Calendar()));
              },
            ),
            //Login
            ListTile(
              leading: Icon(Icons.login),
              title: Text('Login Test'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return Column(
                    children: <Widget>[Login()],
                  );
                }));
              },
            ),
            //Fourms Page
            ListTile(
              leading: Icon(Icons.message),
              title: Text('Fourms'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return Scaffold(
                    appBar: AppBar(
                      title: const Text('Hobby List'),
                    ),
                    body: const Center(
                      child: Text('Demo Home Page for Hobby Hub Hobby Fourms',
                          style: TextStyle(fontSize: 30)),
                    ),
                  );
                }));
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_currentIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
