import 'package:frontend/models/calendarEvent.dart';
// import 'package:frontend/models/dayOfProgram.dart';

import '../repositories/repository.dart';

class CalendarEventController {
  final Repository _repository;

  CalendarEventController(this._repository);
  Future<Map<DateTime, List<String>>> getEvents() async {
    Map<DateTime, List<String>> programEventList = {};
    List<CalendarEvent> events =
        await _repository.getAllObject() as List<CalendarEvent>;
    for (var event in events) {
      programEventList[event.eventDate!] = event.programs;
    }
    return programEventList;
  }

  // wating for DayOfProgram model
  // Future<Map<DateTime, Map<String,List<DayOfProgram>>>> getEvents() async {
  //   Map<DateTime, Map<String,List<DayOfProgram>>> events = {};
  //   List<CalendarEvent> eventList =
  //       await _repository.getAllObject() as List<CalendarEvent>;
  //   for (var event in eventList) {
  //     Map<String, List<DayOfProgram>>
  //     event.dayProgram
  //     events[event.eventDate!] = event.programs;
  //   }
  //   return events;
  // }

}
