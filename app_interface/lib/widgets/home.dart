import 'package:flutter/material.dart';
import 'package:hobby_hub/widgets/auth.dart';
import 'package:provider/provider.dart';

import '../widgets/metronome.dart';
import '../widgets/timer.dart';
import '../widgets/calendar.dart';
import '../theme.dart';
import '../shared/loading.dart';
import '../widgets/homePage.dart';
import './hobbyClass.dart';
import '../widgets/Notes.dart';
import '../widgets/todolist.dart';

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
  String _currentAppBarName = "Home";
  bool loading = false;
  String selectedHobby = "Hobby1";

  //Called when an item is tapped on the bottom nav bar
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
      _currentAppBarName = _appBarNames[index];
    });
  }

  //List of widgets for the bottom bar
  static List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    TimerPage(),
    Calendar(),
    MetronomeControl(),
    NotesPage(),
  ];

  static List<String> _appBarNames = <String>[
    "Home",
    "Timer",
    "Calendar",
    "Metronome",
    "Notes",
  ];

  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              title: Text(
                '$_currentAppBarName',
              ),
              backgroundColor: myTheme.primaryColor,
              actions: <Widget>[
                FlatButton.icon(
                    icon: Icon(Icons.person),
                    label: Text('Logout'),
                    onPressed: () async {
                      setState(() {
                        loading = true;
                      });
                      await _auth.signOut();
                    }),
                //Menu for the diffrent Menu options
              ],
            ),
            body: ChangeNotifierProvider(
                create: (_) => HobbyInfo(),
                child: IndexedStack(
                  index: _currentIndex,
                  children: _widgetOptions,
                )),
            bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: myTheme.primaryColor,
              unselectedItemColor: myTheme.accentColor,
              currentIndex: _currentIndex,
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.timer), label: 'Timer'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.calendar_today_outlined),
                    label: 'Calendar'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.music_note), label: 'Metronome'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.archive), label: 'Notes'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.archive), label: 'To do List'),
              ],
              onTap: _onItemTapped,
            ),
          );
  }
}
