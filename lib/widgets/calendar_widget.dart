import 'package:flutter/material.dart';
import 'package:frontend/models/dayOfProgram.dart';
import 'package:frontend/models/program.dart';
import 'package:frontend/repositories/calendarEvent_repo.dart';
import 'package:table_calendar/table_calendar.dart';
import '../controllers/calendarEvent_controller.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  late Map<DateTime, List<Program>> selectedEvents;
  // Map<DateTime, Map<String, List<DayOfProgram>>> selectedEvents = {};
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  CalendarEventController calendarEventController =
      CalendarEventController(CalendarEventRepo());

  @override
  void initState() {
    selectedEvents = {};
    loadData();
    super.initState();
  }

  void loadData() async {
    selectedEvents = await calendarEventController.getEventsByProgram();
    print('selectedEvent init: $selectedEvents');
    selectedDay =
        DateTime.utc(focusedDay.year, focusedDay.month, focusedDay.day);
    focusedDay =
        DateTime.utc(focusedDay.year, focusedDay.month, focusedDay.day);

    _onDaySelected(selectedDay, focusedDay);
    // _getEventsFromDay(selectedDay);
  }

  List<Program> _getEventsFromDay(DateTime date) {
    return selectedEvents[date] ?? [];
  }

  void _onDaySelected(DateTime selectDay, DateTime focusDay) {
    setState(() {
      selectedDay = selectDay;
      focusedDay = focusDay;
    });
    print('focusedDay: $focusedDay, selectedDay: $selectedDay');
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
              .map((e) => ListTile(title: Text(e.programName!))),
        ],
      ),
    );
  }
}
