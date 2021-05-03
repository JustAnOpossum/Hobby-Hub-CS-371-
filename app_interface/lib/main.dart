import 'package:flutter/material.dart';
import 'package:hobby_hub/widgets/auth.dart';
import 'package:hobby_hub/widgets/wrapper.dart';
import 'package:provider/provider.dart';

import 'package:firebase_core/firebase_core.dart';

import './models/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

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
