import 'package:flutter/material.dart';
import 'package:hobby_hub/widgets/auth.dart';
import 'package:hobby_hub/widgets/wrapper.dart';
import 'package:provider/provider.dart';

import './widgets/timer.dart';
import './widgets/calendar.dart';

import 'package:firebase_core/firebase_core.dart';

import 'models/userData.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

var myTheme =
    ThemeData(primaryColor: Color(0xFFAF5D63), accentColor: Color(0xFFD5896F));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserData>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
