import 'package:frontend/models/calendarEvent.dart';
import 'package:frontend/models/dayOfProgram.dart';
import 'package:frontend/models/program.dart';

import '../repositories/repository.dart';

class CalendarEventController {
  final Repository _repository;

  CalendarEventController(this._repository);
  Future<Map<DateTime, List<Program>>> getEventsByProgram() async {
    Map<DateTime, List<Program>> programEventList = {};
    List<CalendarEvent> events =
        await _repository.getAllObject() as List<CalendarEvent>;
    for (var event in events) {
      programEventList[event.eventDate!] = event.programs;
    }
    return programEventList;
  }

  // Future<Map<DateTime, Map<String, List<DayOfProgram>>>> getEvents() async {
  //   Map<DateTime, Map<String, List<DayOfProgram>>> events = {};
  //   List<CalendarEvent> eventList =
  //       await _repository.getAllObject() as List<CalendarEvent>;
  //   for (var event in eventList) {
  //     Map<String, List<DayOfProgram>> programWorkouts = Map.fromIterable(
  //         event.dayProgram,
  //         key: (e) => e.sId,
  //         value: (e) => e);
  //     events[event.eventDate!] = programWorkouts;
  //   }
  //   print('events: $events');
  //   return events;
  // }
}
