import 'package:flutter/material.dart';
import 'dart:async';
import 'package:audioplayers/audio_cache.dart';

import '../theme.dart';

class TimerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                height: 20,
              ),
              Text(
                'This timer is can help you focus by spacing out when you take a break to keep maximum concentration.',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              Container(
                height: 10,
              ),
              Text(
                '1. Focus for 25 minutes.',
                style: TextStyle(fontSize: 15),
                textAlign: TextAlign.center,
              ),
              Text(
                '2. Take a 5 minute break',
                style: TextStyle(fontSize: 15),
                textAlign: TextAlign.center,
              ),
              Text(
                '3. Repeat step 1 and 2, 4 times.',
                style: TextStyle(fontSize: 15),
                textAlign: TextAlign.center,
              ),
              Text(
                '4. Take a 20 minute long break.',
                style: TextStyle(fontSize: 15),
                textAlign: TextAlign.center,
              ),
              Text(
                '5. Start at step 1 again.',
                style: TextStyle(fontSize: 15),
                textAlign: TextAlign.center,
              ),
              Container(
                height: 20,
              ),
              TimerWidget()
            ],
          ),
        )));
  }
}

class TimerWidget extends StatefulWidget {
  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  String _currentMode = "Practice";
  String _timerMsg = "25:00";
  String _mode = "Start";
  int _timerMinute = 25;
  int _timerSecond = 0;
  int _count = 1;
  int _longRestCount = 1;
  bool _inBreak = false;
  bool _inLongRest = false;
  var _timerColor = Colors.orange;

  Timer _timer;

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }

  //Timer object to track how long the user has been practicing.
  void _timerButtonPressed() {
    //If there is on timer object create one and start it
    if (_timer == null) {
      _timer = new Timer.periodic(Duration(seconds: 1), _updateTimer);
      _updateTimer(_timer);
      setState(() {
        _mode = "Pause";
      });
    } else {
      _stopTimer();
    }
  }

  void _updateTimer(Timer timer) {
    setState(() {
      //Logic to handle when the timer is at 00:00
      _timerSecond--;

      if (_timerMinute == 0 && _timerSecond == 0) {
        _stopTimer();
        _playAudio();
        //If for checking to see if the count is at 4 and it is in break and currently not in a long rest
        if (_count == 2 && _inBreak && !_inLongRest) {
          _timerMinute = 20;
          _timerSecond = 0;
          _currentMode = 'Long Rest';
          _count = _longRestCount;
          _longRestCount++;
          _inLongRest = true;
          _timerColor = Colors.blue;
        } else {
          //Else for when it is not in long rest
          if (_inLongRest) {
            //Resets the state
            _count = 0;
            _inLongRest = false;
          }
          if (_inBreak) {
            _timerMinute = 25;
            _timerSecond = 0;
            _inBreak = false;
            _count++;
            _currentMode = 'Practice';
            _timerColor = Colors.orange;
          } else {
            _timerMinute = 5;
            _timerSecond = 0;
            _inBreak = true;
            _currentMode = 'Break';
            _timerColor = Colors.green;
          }
        }
      }

      if (_timerSecond == -1) {
        _timerSecond = 59;
        _timerMinute--;
      }
      //Makes sure formatting is correct for under 10 seconds
      _timerMsg = (_timerSecond >= 10)
          ? '$_timerMinute:$_timerSecond'
          : '$_timerMinute:0$_timerSecond';
    });
  }

  //Stops the timer and destroys the object
  void _stopTimer() {
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
      setState(() {
        _mode = "Start";
      });
    }
  }

  //Called whenever the reset button is pressed
  //Resets everything to it's inital state.
  void _resetButtonPressed() {
    _stopTimer();
    setState(() {
      _currentMode = "Practice";
      _timerMsg = "25:00";
      _mode = "Start";
      _timerMinute = 25;
      _timerSecond = 0;
      _count = 1;
      _longRestCount = 1;
      _inBreak = false;
      _inLongRest = false;
      _timerColor = Colors.orange;
    });
  }

  void _playAudio() {
    AudioCache cache = new AudioCache();
    cache.play("alarm.mp3");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () => _timerButtonPressed(),
          child: Text('$_mode $_currentMode $_count'),
          style: ElevatedButton.styleFrom(primary: myTheme.accentColor),
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.red),
            onPressed: () => _resetButtonPressed(),
            child: Text('Reset Timer')),
        Container(
          height: 20,
        ),
        Text(
          '$_currentMode',
          style: TextStyle(fontSize: 50),
        ),
        Text(
          '$_timerMsg',
          style: TextStyle(fontSize: 30, color: _timerColor),
        )
      ],
    );
  }
}
