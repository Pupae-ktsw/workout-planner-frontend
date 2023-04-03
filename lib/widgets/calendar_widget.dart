import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:frontend/models/calendarEvent.dart';
import 'package:frontend/models/dayOfProgram.dart';
import 'package:frontend/models/program.dart';
import 'package:frontend/repositories/calendarEvent_repo.dart';
import 'package:frontend/views/planner_page.dart';
import 'package:table_calendar/table_calendar.dart';
import '../controllers/calendarEvent_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:frontend/controllers/day_of_program_controller.dart';
import 'package:frontend/repositories/day_of_program_repo.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({Key? key}) : super(key: key);

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

enum Actions { Done, Skip }

class _CalendarWidgetState extends State<CalendarWidget> {
  Map<DateTime, List<DayOfProgram>> selectedWorkouts = {};
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  bool _isLoading = true;
  DayOfProgramController dayOfProgramController =
      DayOfProgramController(DayOfProgramRepo());

  CalendarEventController calendarEventController =
      CalendarEventController(CalendarEventRepo());

  @override
  void initState() {
    loadData();
    super.initState();
  }

  void loadData() async {
    List<CalendarEvent> events = await calendarEventController.getAllEvents();
    for (var event in events) {
      selectedWorkouts[event.eventDate!] = event.dayProgram;
    }

    // selectedEvents = await calendarEventController.getEventsByProgram();
    // print('selectedEvent init: $selectedEvents');
    selectedDay =
        DateTime.utc(focusedDay.year, focusedDay.month, focusedDay.day);
    focusedDay =
        DateTime.utc(focusedDay.year, focusedDay.month, focusedDay.day);

    _onDaySelected(selectedDay, focusedDay);
    setState(() {
      _isLoading = false;
    });
  }

  // List<Program> _getEventsFromDay(DateTime date) {
  //   return selectedEvents[date] ?? [];
  // }

  List<DayOfProgram> _getEventsFromDay(DateTime date) {
    return selectedWorkouts[date] ?? [];
  }

  void _onDaySelected(DateTime selectDay, DateTime focusDay) {
    // Slidable.of(context)!.close();
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
              weekdayStyle: const TextStyle(fontWeight: FontWeight.bold),
              weekendStyle: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.red.shade600),
            ),
          ),
          Container(
            // padding: const EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.55,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25)),
              color: Colors.grey.shade900,
            ),
            child: SlidableAutoCloseBehavior(
              closeWhenOpened: true,
              child: ListView(children: [
                ..._getEventsFromDay(selectedDay).map(
                  (e) => Slidable(
                    enabled: e.workoutStatus == "Done" ? false : true,
                    endActionPane: ActionPane(
                      motion: StretchMotion(),
                      children: [
                        SlidableAction(
                            backgroundColor: Colors.green,
                            icon: Icons.check,
                            label: "Done",
                            onPressed: (context) =>
                                _changeStatus(e, Actions.Done)),
                        SlidableAction(
                          backgroundColor: Colors.red,
                          icon: Icons.self_improvement_sharp,
                          label: "Skip",
                          onPressed: (context) =>
                              _changeStatus(e, Actions.Skip),
                        ),
                      ],
                    ),
                    child: InkWell(
                      onTap: () async {
                        final youtubeUrl = Uri.parse(e.youtubeVid!.url!);
                        await launchUrl(youtubeUrl);
                      },
                      child: Stack(children: [
                        Container(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(7.0),
                                    child: Image.network(
                                      e.youtubeVid!.thumbnail!,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    right: 4,
                                    bottom: 4,
                                    child: e.workoutStatus == "Done"
                                        ? Icon(
                                            Icons.check_circle_sharp,
                                            size: 32,
                                            color: Colors.white,
                                          )
                                        : Container(),
                                  )
                                ],
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      e.program!.programName!,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Day : ${e.numberOfDay}/${e.program!.totalDays!}',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      e.youtubeVid!.title!,
                                      // overflow: TextOverflow.ellipsis,
                                      // maxLines: 2,
                                      // softWrap: true,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ]),
                    ),
                  ),
                )
              ]),
            ),
          ),
        ],
      ),
    );
  }

  _changeStatus(DayOfProgram dayOfProgram, Actions action) {
    // final day = ;

    setState(() {
      switch (action) {
        case Actions.Done:
          //call controller to update status
          dayOfProgram.workoutStatus = "Done";
          dayOfProgramController.updateDayOfProgram(dayOfProgram);
          _showSnackBar(context,
              "${dayOfProgram.program!.programName} is done!", Colors.green);
          break;
        case Actions.Skip:
          //call controller to update status
          dayOfProgram.workoutStatus = "Skip";
          dayOfProgramController.updateDayOfProgram(dayOfProgram);
          _showSnackBar(context,
              "${dayOfProgram.program!.programName} is skip!", Colors.red);
          setState(() {
            _isLoading = true;
          });
          break;
      }
    });
  }

  void _showSnackBar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
      backgroundColor: color,
    ));
  }
}
