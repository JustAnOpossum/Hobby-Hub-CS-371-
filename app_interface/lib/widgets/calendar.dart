import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:provider/provider.dart';
import './hobbyClass.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime _currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final hobbyState = Provider.of<HobbyInfo>(context);

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
              double hours = hobbyState.getEventTimes[event.getTitle()];
              _modalList.add(new Text(
                '$title: $hours Hours',
                style: TextStyle(fontSize: 40),
              ));
            });
            _currentDate = date;
            //When the event is clicked, shows a modal with the hours practiced
            if (_modalList.length != 0) {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: _modalList,
                    );
                  });
            }
          });
        },
        selectedDateTime: _currentDate,
        markedDatesMap: hobbyState.getEvents,
      ),
    );
  }
}
