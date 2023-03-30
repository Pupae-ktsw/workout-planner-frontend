import 'package:flutter/material.dart';
import 'package:frontend/models/calendarEvent.dart';
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
  Map<DateTime, List<Program>> selectedEvents = {};
  Map<DateTime, List<DayOfProgram>> selectedWorkouts = {};
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  CalendarEventController calendarEventController =
      CalendarEventController(CalendarEventRepo());

  @override
  void initState() {
    selectedEvents = {};
    // loadData();
    super.initState();
  }

  void loadData() async {
    List<CalendarEvent> events = await calendarEventController.getAllEvents();
    for (var event in events) {
      selectedWorkouts[event.eventDate!] = event.dayProgram;
    }

    // selectedEvents = await calendarEventController.getEventsByProgram();
    print('selectedEvent init: $selectedEvents');
    selectedDay =
        DateTime.utc(focusedDay.year, focusedDay.month, focusedDay.day);
    focusedDay =
        DateTime.utc(focusedDay.year, focusedDay.month, focusedDay.day);

    _onDaySelected(selectedDay, focusedDay);
  }

  // List<Program> _getEventsFromDay(DateTime date) {
  //   return selectedEvents[date] ?? [];
  // }

  List<DayOfProgram> _getEventsFromDay(DateTime date) {
    return selectedWorkouts[date] ?? [];
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
            // eventLoader: _getEventsFromDay,
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
              weekdayStyle: const TextStyle(fontWeight: FontWeight.bold),
              weekendStyle: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.red.shade600),
            ),
          ),
          /*Container(child: ListView.separated(itemBuilder: ((context,(context, index) {
            
          })), separatorBuilder: separatorBuilder, itemCount: itemCount),
              padding: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.55,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50)),
                color: Colors.grey.shade900,
                // boxShadow: const [
                //   BoxShadow(
                //     blurRadius: 10.0,
                //     color: Colors.black,
                //   ),
                // ],
              ),

          ),*/

          // ..._getEventsFromDay(selectedDay)
          //   .map((e) => null))

          // ..._getEventsFromDay(selectedDay)
          //     .map((e) => ListTile(title: Text(e.programName!))),

          // ..._getEventsFromDay(selectedDay)
          //     .map((e) => Column(
          //       children: [ Text(e.programName!),
          //         // var workouts = _getWorkoutsByPgId(selectedDay, e.id);
          //         // for(int i = 0 ; _getWorkoutsByPgId(selectedDay, e.id));
          //         for(var workout in _getWorkoutsByPgId(selectedDay, e.id!)) ...[
          //           Row(
          //             children: [
          //               Image.network(workout.)
          //             ],
          //           ),
          //         ]

          //       ],
          //     )),
        ],
      ),
    );
  }
}
