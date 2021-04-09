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

  //List of events for the calendar
  EventList<Event> _dateMap = new EventList<Event>(events: {
    new DateTime(2021, 4, 4): [
      new Event(date: new DateTime(2021, 4, 4), title: 'Test', id: 0)
    ],
    new DateTime(2021, 4, 5): [
      new Event(date: new DateTime(2021, 4, 5), title: 'Test2', id: 1),
      new Event(date: new DateTime(2021, 4, 5), title: 'Test3', id: 2),
    ],
  });

  //Times for the events
  List<int> _eventTimes = [1, 2, 3];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CalendarCarousel<Event>(
        onDayPressed: (DateTime date, List<Event> events) {
          setState(() {
            //List for the modal widgets
            List<Widget> _modalList = List<Widget>.empty(growable: true);
            //Goes through the events and adds them to the list
            events.forEach((event) {
              String title = event.title;
              int hours = _eventTimes[event.id];
              _modalList.add(new Text(
                '$title: $hours',
                style: TextStyle(fontSize: 40),
              ));
            });
            _currentDate = date;
            //When the event is clicked, shows a modal with the hours practiced
            showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: _modalList,
                  );
                });
          });
        },
        selectedDateTime: _currentDate,
        markedDatesMap: _dateMap,
      ),
    );
  }
}
