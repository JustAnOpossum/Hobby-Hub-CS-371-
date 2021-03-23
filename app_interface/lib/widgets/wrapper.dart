import 'package:flutter/material.dart';
import 'package:hobby_hub/models/userData.dart';
import 'package:hobby_hub/widgets/authenticate.dart';
import 'package:provider/provider.dart';

import 'home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData>(context);
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
