import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/calendarEvent.dart';
import 'package:http/http.dart' as http;

/*class CalendarWidget extends StatelessWidget {
  DateTime today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime(today.year - 2),
      lastDay: DateTime(today.year + 1),
      focusedDay: today,
      headerStyle: HeaderStyle(formatButtonVisible: false, titleCentered: true),
      availableGestures: AvailableGestures.all,
      availableCalendarFormats: const {
        CalendarFormat.week: 'Week',
        CalendarFormat.month: 'Month',
      },
      // initialCalendarFormat: CalendarFormat.month,
    );
    // return SfCalendar(
    //   view: CalendarView.month,
    //   cellBorderColor: Colors.transparent,
    //   todayHighlightColor: Colors.red.shade600,
    //   selectionDecoration: BoxDecoration(
    //     color: Colors.transparent,
    //     border: Border.all(color: Colors.red.shade600),
    //   ),
    // );
  }
}*/

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  Map<DateTime, List<CalendarEvent>> selectedEvents = {};
  DateTime selectedDay = DateTime.now();
  DateTime today = DateTime.now();

  CalendarController calendarController = calendarController();

  Future<List<CalendarEvent>> _fetchEvents() async {
    final response = await http.get(Uri.parse(uri));
    final events = await db.query('events');
    return events.map((e) => CalendarEvent.fromMap(e)).toList();
  }

  // List<Event> _getEventsFromDay(DateTime date) {
  //   return selectedEvents[date] ?? [];
  // }

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      selectedDay = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: TableCalendar(
        firstDay: DateTime(today.year - 2),
        lastDay: DateTime(today.year + 2),
        focusedDay: selectedDay,
        // eventLoader: _,
        headerStyle:
            HeaderStyle(formatButtonVisible: false, titleCentered: true),
        availableGestures: AvailableGestures.all,
        onDaySelected: _onDaySelected,
        selectedDayPredicate: ((day) => isSameDay(day, selectedDay)),
        calendarStyle: CalendarStyle(
          todayDecoration: BoxDecoration(
              color: today == selectedDay
                  ? Colors.red.shade600
                  : Colors.red.shade200,
              shape: BoxShape.circle),
          selectedDecoration:
              BoxDecoration(color: Colors.red.shade600, shape: BoxShape.circle),
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: TextStyle(fontWeight: FontWeight.bold),
          weekendStyle: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.red.shade600),
        ),
      ),
    );
  }
}
