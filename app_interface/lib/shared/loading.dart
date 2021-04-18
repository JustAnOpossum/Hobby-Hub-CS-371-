import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import '../theme.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: myTheme.accentColor,
        child: Center(
          child: SpinKitFadingCircle(color: myTheme.primaryColor, size: 50.0),
        ));
  }
}
