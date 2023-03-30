import 'package:frontend/models/calendarEvent.dart';
import 'package:frontend/models/dayOfProgram.dart';
import 'package:frontend/models/program.dart';

import '../repositories/repository.dart';

class CalendarEventController {
  final Repository _repository;

  CalendarEventController(this._repository);
  Future<List<CalendarEvent>> getAllEvents() async {
    List<CalendarEvent> events =
        await _repository.getAllObject() as List<CalendarEvent>;
    return events;
  }

  // Map<String, List<DayOfProgram>> getWorkoutsByDate(
  //     List<CalendarEvent> events, String programId, DateTime selectedDay) {
  //   Map<String, List<DayOfProgram>> workouts = {};
  //   CalendarEvent event =
  //       events.singleWhere((e) => e.eventDate!.compareTo(selectedDay) == 0);
  //   List<DayOfProgram> dayPgList = event.dayProgram;
  //   dayPgList.where((dayPg) => dayPg.programId == programId);
  //   for (var dayPgs in event.dayProgram) {
  //     dayPgs.where;
  //   }
  //   return workouts;
  // }

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
