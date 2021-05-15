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
              double hours = hobbyState.getEvent(event.date).hours;
              var formatHours = hours.toStringAsFixed(2);
              _modalList.add(new Text(
                '$title: $formatHours Hours',
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
        //UI for the user to be able to delete and create events
        onDayLongPressed: (DateTime date) async {
          String _popupString = "";
          String _currentHobby = hobbyState.getHobby;
          bool _eventExists =
              (hobbyState.getEvent(date) == null) ? false : true;
          if (_eventExists) {
            _popupString = "Update Event For $_currentHobby";
          } else {
            _popupString = "Create Event For $_currentHobby";
          }
          double hours = await asyncInputDialog(context, _popupString);

          //Deletes the event
          if (hours == -1) {
            hobbyState.deleteEvent(hobbyState.getEvent(date).id);
            return;
          }

          if (hours == 0) return;

          //Case for updating the event
          if (_eventExists) {
            hobbyState.updateEvent(hobbyState.getEvent(date).id, hours);
          } else {
            //Else the new event is created
            hobbyState.createEvent(date, hours);
          }
        },
        selectedDateTime: _currentDate,
        markedDatesMap: hobbyState.calendarEvents,
      ),
    );
  }
}

//Popup whenever the user does a long press on the calendar
Future asyncInputDialog(BuildContext context, String text) async {
  double hours = 0;
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(text),
        content: new Row(
          children: [
            new Expanded(
                child: new TextField(
              autofocus: true,
              decoration:
                  new InputDecoration(labelText: 'Hours', hintText: 'ex. 5'),
              onChanged: (value) {
                hours = double.parse(value);
              },
            ))
          ],
        ),
        actions: [
          FlatButton(
            child: Text('Save'),
            onPressed: () {
              Navigator.of(context).pop(hours);
            },
          ),
          FlatButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop(hours);
            },
          ),
          FlatButton(
            child: Text('Delete'),
            onPressed: () {
              hours = -1;
              Navigator.of(context).pop(hours);
            },
          ),
        ],
      );
    },
  );
}
