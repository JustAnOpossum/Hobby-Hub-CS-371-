import 'package:flutter/material.dart';
import 'dart:async';

class TimerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Timer'),
        ),
        body: Center(
            child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                'Pomodoro Timer',
                style: TextStyle(fontSize: 40),
              ),
              Container(
                height: 20,
              ),
              Text(
                'This timer is can help you focus on your task at hand, try it out and see if you like it!',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              Container(
                height: 10,
              ),
              Text(
                'A cycle is 30 minutes. 25 which you are practicing and 5 of resting. You do 4 cycles and then start again',
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
        print(_inBreak);
        //If for checking to see if the count is at 4 and it is in break and currently not in a long rest
        if (_count == 2 && _inBreak && !_inLongRest) {
          _timerMinute = 20;
          _timerSecond = 0;
          _currentMode = 'Long Rest';
          _count = _longRestCount;
          _longRestCount++;
          _inLongRest = true;
        } else {
          //Else for when it is not in long rest
          if (_inLongRest) {
            //Resets the state
            _count = 0;
            _inLongRest = false;
          }
          if (_inBreak) {
            _timerMinute = 5;
            _timerSecond = 0;
            _inBreak = false;
            _count++;
            _currentMode = 'Practice';
          } else {
            _timerMinute = 25;
            _timerSecond = 0;
            _inBreak = true;
            _currentMode = 'Break';
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
            onPressed: () => _timerButtonPressed(),
            child: Text('$_mode $_currentMode $_count')),
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
          style: TextStyle(fontSize: 30, color: Colors.orange),
        )
      ],
    );
  }
}