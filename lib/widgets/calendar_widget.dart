import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:frontend/models/calendarEvent.dart';
import 'package:frontend/models/dayOfProgram.dart';
import 'package:frontend/models/program.dart';
import 'package:frontend/repositories/calendarEvent_repo.dart';
import 'package:table_calendar/table_calendar.dart';
import '../controllers/calendarEvent_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

enum Actions { Done, Undone }

class _CalendarWidgetState extends State<CalendarWidget> {
  Map<DateTime, List<DayOfProgram>> selectedWorkouts = {};
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

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
                              _changeStatus(e, Actions.Undone),
                        ),
                      ],
                    ),
                    child: InkWell(
                      onTap: () async {
                        final youtubeUrl = Uri.parse(e.youtubeVid!.url!);
                        await launchUrl(youtubeUrl);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(7.0),
                              child: Image.network(
                                e.youtubeVid!.thumbnail!,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
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
                                  Text(
                                    'Day ${e.numberOfDay}/${e.program!.totalDays!}',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    e.youtubeVid!.title!,
                                    // overflow: TextOverflow.ellipsis,
                                    // maxLines: 2,
                                    // softWrap: true,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
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
    setState(() {
      //call controller to update status
    });

    switch (action) {
      case Actions.Done:
        //call controller to update status
        break;
      case Actions.Undone:
        //call controller to update status
        break;
    }
  }
}
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