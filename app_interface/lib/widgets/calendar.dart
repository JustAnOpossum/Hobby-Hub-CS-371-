import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime _currentDate = DateTime.now();

  EventList<Event> _dateMap = new EventList<Event>(events: {
    new DateTime(2021, 3, 29): [
      new Event(
        date: new DateTime(2021, 3, 29),
        title: 'Test',
      )
    ]
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CalendarCarousel<Event>(
        onDayPressed: (DateTime date, List<Event> events) {
          setState(() {
            _currentDate = date;
          });
        },
        selectedDateTime: _currentDate,
        markedDatesMap: _dateMap,
      ),
    );
  }
}
