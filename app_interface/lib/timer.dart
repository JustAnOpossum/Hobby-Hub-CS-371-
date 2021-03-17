import 'package:flutter/material.dart';

class TimerPage extends StatefulWidget {
  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
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
              ElevatedButton(onPressed: () {}, child: Text('Start Timer')),
              Container(
                height: 20,
              ),
              Timer(),
            ],
          ),
        )));
  }
}

class Timer extends StatefulWidget {
  @override
  _TimerState createState() => _TimerState();
}

class _TimerState extends State<Timer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Practice:',
          style: TextStyle(fontSize: 50),
        ),
        Text(
          '25:00',
          style: TextStyle(fontSize: 30, color: Colors.orange),
        )
      ],
    );
  }
}
