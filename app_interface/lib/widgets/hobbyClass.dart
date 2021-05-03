import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';

class DatabaseEvent {
  int month;
  int day;
  int year;
  double hours;
  String name;

  DatabaseEvent(
      int newMonth, int newDay, int newYear, double newHours, String newName) {
    month = newMonth;
    day = newDay;
    year = newYear;
    hours = newHours;
    name = newName;
  }

  Map toJson() =>
      {'month': month, 'day': day, 'year': year, 'hours': hours, 'name': name};

  DatabaseEvent.fromJson(Map inputJson)
      : month = inputJson['month'],
        day = inputJson['day'],
        year = inputJson['year'],
        hours = inputJson['hours'],
        name = inputJson['name'];
}

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
    //Database call to load databaseHobbies
    //Mock data for now
    String _databaseHobbies = "[\"Hobby1\"]";
    List _databaseList = jsonDecode(_databaseHobbies);

    _databaseList.forEach((element) {
      _allHobbies.add(element);
    });

    _currentHobby = _allHobbies.length == 0 ? "None" : _allHobbies[0];
    _reloadEvents();
  }

  //Adds a hobby to the list and notifies widgets that there is a change
  //Saves new hobby name to database if it does not already exist
  void addHobby(String name) {
    _allHobbies.add(name);

    //JSON string to save to database
    String _databaseJSON = jsonEncode(_allHobbies);

    notifyListeners();
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

    //Load all event objects from the database matching _currentHobby
    //Use a for loop over the objects returned
    //Mock data for now
    for (int i = 0; i < 1; i++) {
      DatabaseEvent mockEvent = new DatabaseEvent(5, 2, 2021, 5, 'Hobby1');
      String mockEventJson = jsonEncode(mockEvent.toJson());
      String inputJson = mockEventJson;
      DatabaseEvent _event = DatabaseEvent.fromJson(jsonDecode(inputJson));
      createEvent(new DateTime(_event.year, _event.month, _event.day),
          _event.hours, _event.name);
    }

    notifyListeners();
  }

  //Creates an event with epcified date, time and hobby
  void createEvent(DateTime eventDate, double eventTime, String eventName) {
    _calendarEvents.add(
        eventDate, new Event(date: eventDate, title: eventName));
    _eventTimes[eventName] = eventTime;

    //save the newEvent json to the database
    DatabaseEvent newEvent = new DatabaseEvent(
        eventDate.month, eventDate.day, eventDate.year, eventTime, eventName);
    String newEventJson = jsonEncode(newEvent);
    notifyListeners();
  }

  //Updates an event with a new time
  void updateEvent(DateTime dateToModify, double newTime) {
    //Looks for events matching that date
    var event = _calendarEvents.getEvents(dateToModify);

    //If event does not exist, create it
    if (event.length == 0) {
      createEvent(dateToModify, newTime, _currentHobby);
      event = _calendarEvents.getEvents(dateToModify);
    }

    //Update the time
    _eventTimes[event[0].getTitle()] += newTime;

    //update the event matching the date and title in the database using newEvent json
    DatabaseEvent newEvent = new DatabaseEvent(
        dateToModify.month,
        dateToModify.day,
        dateToModify.year,
        _eventTimes[event[0].getTitle()],
        event[0].getTitle());
    String newEventJson = jsonEncode(newEvent);

    notifyListeners();
  }

  bool eventExists(DateTime checkDate) {
    var events = _calendarEvents.getEvents(checkDate);
    if (events.length == 0) {
      return false;
    }
    return true;
  }
}
