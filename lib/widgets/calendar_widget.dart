import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../controllers/calendarEvent_controller.dart';
import '../models/calendarEvent.dart';
import 'package:http/http.dart' as http;

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  late Map<DateTime, List<String>> selectedEvents;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  // DateTime today = DateTime.now();

  TextEditingController _eventController = TextEditingController();

  @override
  void initState() {
    selectedEvents = {};
    // CalendarEventController.get
    /* Mock data
    const programs = ['EPIC Heat', 'Epic EndGame', 'Fuel Series'];
    DateTime today = DateTime.now();
    DateTime next2days = today.add(Duration(days: 2));

    CalendarEvent calendar = CalendarEvent(
        programs: programs,
        eventDate: DateTime.utc(today.year, today.month, today.day));
    CalendarEvent calendar2 = CalendarEvent(
        programs: programs,
        eventDate:
            DateTime.utc(next2days.year, next2days.month, next2days.day));

    List<CalendarEvent> calendarList = [calendar, calendar2];
    setState(() {
      calendarList.forEach((item) {
        selectedEvents[item.eventDate!] = item.programs;
      });
    });
    // print('SelectedEvents: $selectedEvents');

    _onDaySelected(DateTime.utc(today.year, today.month, today.day),
        DateTime.utc(today.year, today.month, today.day));*/
    super.initState();
  }

  List<String> _getEventsFromDay(DateTime date) {
    // print('getevents from: $date');
    // print('event is: ${selectedEvents[date]}');
    return selectedEvents[date] ?? [];
  }

  @override
  void dispose() {
    _eventController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime selectDay, DateTime focusDay) {
    setState(() {
      selectedDay = selectDay;
      focusedDay = focusDay;
    });
    print('focusedDay: $focusedDay');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          TableCalendar(
            firstDay: DateTime(2000),
            lastDay: DateTime(2050),
            focusedDay: selectedDay,
            calendarFormat: CalendarFormat.month,
            startingDayOfWeek: StartingDayOfWeek.sunday,
            daysOfWeekVisible: true,
            eventLoader: _getEventsFromDay,
            availableGestures: AvailableGestures.all,
            onDaySelected: _onDaySelected,
            selectedDayPredicate: ((date) => isSameDay(selectedDay, date)),
            headerStyle: const HeaderStyle(
                formatButtonVisible: false, titleCentered: true),
            calendarStyle: CalendarStyle(
              isTodayHighlighted: true,
              defaultDecoration: const BoxDecoration(shape: BoxShape.circle),
              todayDecoration: BoxDecoration(
                  color: Colors.red.shade200, shape: BoxShape.circle),
              todayTextStyle: const TextStyle(color: Colors.black),
              selectedDecoration: BoxDecoration(
                  color: Colors.red.shade600, shape: BoxShape.circle),
              selectedTextStyle: const TextStyle(color: Colors.white),
            ),
            daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: TextStyle(fontWeight: FontWeight.bold),
              weekendStyle: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.red.shade600),
            ),
          ),
          ..._getEventsFromDay(selectedDay)
              .map((e) => ListTile(title: Text(e))),
        ],
      ),
    );
  }
}
