import 'package:flutter/cupertino.dart';

import '../widgets/hobbyClass.dart';

class Person {
  final String email;
  final String displayName;
  List calendarEvents = [];

  Person({this.displayName, this.email, this.calendarEvents});
}
