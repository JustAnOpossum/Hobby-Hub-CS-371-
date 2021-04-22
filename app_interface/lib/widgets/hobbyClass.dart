import 'package:flutter/material.dart';

class HobbyInfo extends ChangeNotifier {
  String _currentHobby = "Hobby1";

  String get getHobby {
    return _currentHobby;
  }

  void updateHobby(String newHobby) {
    _currentHobby = newHobby;
    notifyListeners();
  }
}
