import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';

class HobbyInfo extends ChangeNotifier {
  //String for the current hobby user has selected.
  String _currentHobby = "";
  //List of all avaliable hobbies to select from
  List<String> _allHobbies = [];

  //Event list for calendar
  EventList<Event> _calendarEvents = new EventList<Event>();

  //Hours for each event
  Map<String, double> _eventTimes = new Map();

  String get getHobby {
    return _currentHobby;
  }

  EventList<Event> get getEvents {
    return _calendarEvents;
  }

  Map<String, double> get getEventTimes {
    return _eventTimes;
  }

  List<String> get getAllHobbies {
    return _allHobbies;
  }

  //Constructor, loads hobbies and sets up inital values for the app
  HobbyInfo() {
    //Database call here to load names
    //Mock data for now
    addHobby("Hobby1");
    addHobby("Hobby2");
    _currentHobby = "Hobby1";
  }

  //Adds a hobby to the list and notifies widgets that there is a change
  //Saves new hobby name to database if it does not already exist
  void addHobby(String name) {
    _allHobbies.add(name);
  }

  //Updates current hobby and notifies all widgets listening to that update.
  void updateHobby(String newHobby) {
    _currentHobby = newHobby;
    _reloadEvents();
    notifyListeners();
  }

  //Called when there is a hobby update
  //Loads that hobby info from the database
  void _reloadEvents() {
    _calendarEvents = new EventList<Event>();
    _eventTimes = new Map();

    //Load hobby info from database and call createEvent for each event
    //Mock data for now
    _createEvent(new DateTime(2021, 4, 23), 10, "Hobby1");

    notifyListeners();
  }

  //Creates an event with epcified date, time and hobby
  void _createEvent(DateTime eventDate, double eventTime, String eventName) {
    _calendarEvents.add(
        eventDate, new Event(date: eventDate, title: eventName));
    _eventTimes[eventName] = eventTime;
  }

  //Updates an event with a new time
  void updateEvent(DateTime dateToModify, double newTime) {
    //Looks for events matching that date
    var event = _calendarEvents.getEvents(dateToModify);

    //If event does not exist, create it
    if (event.length == 0) {
      _createEvent(dateToModify, newTime, _currentHobby);
      event = _calendarEvents.getEvents(dateToModify);
    }

    //Update the time
    _eventTimes[event[0].getTitle()] += newTime;

    //Update time in database

    notifyListeners();
  }
}
