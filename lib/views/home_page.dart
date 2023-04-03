import 'package:flutter/material.dart';
import 'package:frontend/controllers/calendarEvent_controller.dart';
import 'package:frontend/controllers/day_of_program_controller.dart';
import 'package:frontend/controllers/program_controller.dart';
import 'package:frontend/models/calendarEvent.dart';
import 'package:frontend/models/dayOfProgram.dart';
import 'package:frontend/models/program.dart';
import 'package:frontend/models/youtubeVid.dart';
import 'package:frontend/provider/programProvider.dart';
import 'package:frontend/repositories/calendarEvent_repo.dart';
import 'package:frontend/repositories/day_of_program_repo.dart';
import 'package:frontend/repositories/program_repo.dart';
import 'package:frontend/views/addProgram_page.dart';
import 'package:frontend/views/dayOfProgramSuggest_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  CalendarEventController _calendarEventController =
      CalendarEventController(CalendarEventRepo());
  DayOfProgramController _dayOfProgramController =
      DayOfProgramController(DayOfProgramRepo());
  ProgramRepo _programRepo = ProgramRepo();

  Future<List<Object>> bodyWeightProgram() async {
    List<Program> programList =
        await _programRepo.getSuggestPrograms() as List<Program>;
    List<Program> bodyWeightProgramList = [];

    for (var i = programList.length - 1; i > 0; i--) {
      bodyWeightProgramList.add(programList[i]);
    }

    return bodyWeightProgramList;
  }

  Future<List<Object>> cardioProgram() async {
    List<Program> programList =
        await _programRepo.getSuggestPrograms() as List<Program>;

    programList.shuffle();

    return programList;
  }

  @override
  Widget build(BuildContext context) {
    DayOfProgramController dayOfProgramController =
        DayOfProgramController(DayOfProgramRepo());
    var programProvider = Provider.of<ProgramProvider>(context, listen: false);
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'WORKOUT PLANNER',
                  style: GoogleFonts.prompt(
                    fontSize: 32,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.topLeft,
                child: Text('Today\'s Programs',
                    style: GoogleFonts.prompt(
                      textStyle: Theme.of(context).textTheme.bodyText1,
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 100,
                child: FutureBuilder(
                  future: _calendarEventController.getAllEvents(),
                  builder: (context, snapshot) {
                    List<CalendarEvent> calendarEventList = [];
                    List<CalendarEvent> todayEventList = [];
                    if (snapshot.hasData) {
                      calendarEventList = snapshot.data as List<CalendarEvent>;
                      for (var i in calendarEventList) {
                        String calendarDate =
                            i.eventDate.toString().substring(0, 10);
                        String DateTimeNow =
                            DateTime.now().toString().substring(0, 10);

                        if (calendarDate == DateTimeNow) {
                          todayEventList.add(i);
                        }
                      }
                    }

                    return calendarEventList.isNotEmpty
                        ? ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: todayEventList.length,
                            itemBuilder: (context, index) {
                              CalendarEvent todayEvent = todayEventList[index];
                              List<DayOfProgram> dayOfProgramList =
                                  todayEvent.dayProgram;
                              print(index);
                              return Row(
                                children: dayOfProgramList.map((dayOfProgram) {
                                  return InkWell(
                                    onTap: () async {
                                      final youtubeUrl = Uri.parse(
                                          dayOfProgram.youtubeVid!.url!);
                                      await launchUrl(youtubeUrl);
                                    },
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: Stack(
                                        children: [
                                          Container(
                                            width: 180,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                              child: Image.network(
                                                dayOfProgram
                                                    .youtubeVid!.thumbnail!,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              gradient: LinearGradient(
                                                begin: Alignment.bottomCenter,
                                                end: Alignment.topCenter,
                                                colors: <Color>[
                                                  Colors.black54,
                                                  Colors.transparent
                                                ],
                                              ),
                                            ),
                                            width: 180,
                                            height: 200,
                                          ),
                                          Positioned(
                                            bottom: 6,
                                            left: 6,
                                            child: Text(
                                              "Day ${dayOfProgram.numberOfDay}/${dayOfProgram.program!.totalDays}",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList(),
                              );
                            },
                          )
                        : Center(child: Text('Today is rest day!'));
                  },
                ),
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.topLeft,
                child: Text('Weight Training Programs',
                    style: GoogleFonts.prompt(
                      textStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  height: 125,
                  child: FutureBuilder(
                    future: _programRepo.getSuggestPrograms(),
                    builder: (context, snapshot) {
                      return snapshot.hasData
                          ? ListView.builder(
                              itemCount: snapshot.data!.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                var program = snapshot.data![index] as Program;
                                return Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: InkWell(
                                    onTap: (() {
                                      setState(() {
                                        programProvider.setProgramName(
                                            program.programName!);
                                        programProvider
                                            .setProgramId(program.id!);
                                      });
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DayOfSuggestPage()));
                                    }),
                                    child: Stack(
                                      children: [
                                        Container(
                                          width: 225,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(7),
                                            child: Image.network(
                                              program.thumbnail!,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            gradient: LinearGradient(
                                              begin: Alignment.bottomCenter,
                                              end: Alignment.topCenter,
                                              colors: <Color>[
                                                Colors.black54,
                                                Colors.transparent
                                              ],
                                            ),
                                          ),
                                          width: 225,
                                          height: 125,
                                        ),
                                        Positioned(
                                          bottom: 6,
                                          left: 6,
                                          child: Text(
                                            "${program.programName}",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )
                          : Container();
                    },
                  )),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.topLeft,
                child: Text('Body Weight Programs',
                    style: GoogleFonts.prompt(
                      textStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  height: 125,
                  child: FutureBuilder(
                    future: bodyWeightProgram(),
                    builder: (context, snapshot) {
                      return snapshot.hasData
                          ? ListView.builder(
                              itemCount: snapshot.data!.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                var program = snapshot.data![index] as Program;
                                return Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: InkWell(
                                    onTap: (() {
                                      setState(() {
                                        programProvider.setProgramName(
                                            program.programName!);
                                        programProvider
                                            .setProgramId(program.id!);
                                      });
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DayOfSuggestPage()));
                                    }),
                                    child: Stack(
                                      children: [
                                        Container(
                                          width: 225,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(7),
                                            child: Image.network(
                                              program.thumbnail!,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            gradient: LinearGradient(
                                              begin: Alignment.bottomCenter,
                                              end: Alignment.topCenter,
                                              colors: <Color>[
                                                Colors.black54,
                                                Colors.transparent
                                              ],
                                            ),
                                          ),
                                          width: 225,
                                          height: 125,
                                        ),
                                        Positioned(
                                          bottom: 6,
                                          left: 6,
                                          child: Text(
                                            "${program.programName}",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )
                          : Container();
                    },
                  )),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.topLeft,
                child: Text('Cardio Programs',
                    style: GoogleFonts.prompt(
                      textStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  height: 125,
                  child: FutureBuilder(
                    future: cardioProgram(),
                    builder: (context, snapshot) {
                      return snapshot.hasData
                          ? ListView.builder(
                              itemCount: snapshot.data!.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                var program = snapshot.data![index] as Program;
                                return Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: InkWell(
                                    onTap: (() {
                                      setState(() {
                                        programProvider.setProgramName(
                                            program.programName!);
                                        programProvider
                                            .setProgramId(program.id!);
                                      });
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DayOfSuggestPage()));
                                    }),
                                    child: Stack(
                                      children: [
                                        Container(
                                          width: 225,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(7),
                                            child: Image.network(
                                              program.thumbnail!,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            gradient: LinearGradient(
                                              begin: Alignment.bottomCenter,
                                              end: Alignment.topCenter,
                                              colors: <Color>[
                                                Colors.black54,
                                                Colors.transparent
                                              ],
                                            ),
                                          ),
                                          width: 225,
                                          height: 125,
                                        ),
                                        Positioned(
                                          bottom: 6,
                                          left: 6,
                                          child: Text(
                                            "${program.programName}",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )
                          : Container();
                    },
                  )),
            ],
            // ),
          ),
        ),
      ),
    ));
  }
}


// // stl
// class HomePage extends StatelessWidget {
//   List testData = [
//     {'name': 'Program 1', 'Type': 'Abs'},
//     {'name': 'Program 2', 'Type': 'Workout'},
//     {'name': 'Program 3', 'Type': 'Workout'},
//     {'name': 'Program 4', 'Type': 'Workout'},
//     {'name': 'Program 5', 'Type': 'Workout'}
//   ];
//   CalendarEventController _calendarEventController =
//       CalendarEventController(CalendarEventRepo());
//   DayOfProgramController _dayOfProgramController =
//       DayOfProgramController(DayOfProgramRepo());
//   ProgramRepo _programRepo = ProgramRepo();
//   ProgramProvider programProvider = ProgramProvider();

//   Future<List<Object>> bodyWeightProgram() async {
//     List<Program> programList =
//         await _programRepo.getSuggestPrograms() as List<Program>;
//     List<Program> bodyWeightProgramList = [];

//     for (var i = programList.length - 1; i > 0; i--) {
//       bodyWeightProgramList.add(programList[i]);
//     }

//     return bodyWeightProgramList;
//   }

//   Future<List<Object>> cardioProgram() async {
//     List<Program> programList =
//         await _programRepo.getSuggestPrograms() as List<Program>;

//     programList.shuffle();

//     return programList;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: SafeArea(
//       child: Padding(
//         padding: const EdgeInsets.only(left: 20),
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               SizedBox(
//                 height: 20,
//               ),
//               Align(
//                 alignment: Alignment.topLeft,
//                 child: Text(
//                   'WORKOUT PLANNER',
//                   style: GoogleFonts.prompt(
//                     fontSize: 32,
//                     fontStyle: FontStyle.italic,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               Align(
//                 alignment: Alignment.topLeft,
//                 child: Text('Today\'s Programs',
//                     style: GoogleFonts.prompt(
//                       textStyle: Theme.of(context).textTheme.bodyText1,
//                     )),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Container(
//                 height: 100,
//                 child: FutureBuilder(
//                   future: _calendarEventController.getAllEvents(),
//                   builder: (context, snapshot) {
//                     List<CalendarEvent> calendarEventList = [];
//                     List<CalendarEvent> todayEventList = [];
//                     if (snapshot.hasData) {
//                       calendarEventList = snapshot.data as List<CalendarEvent>;
//                       for (var i in calendarEventList) {
//                         String calendarDate =
//                             i.eventDate.toString().substring(0, 10);
//                         String DateTimeNow =
//                             DateTime.now().toString().substring(0, 10);

//                         if (calendarDate == DateTimeNow) {
//                           todayEventList.add(i);
//                         }
//                       }
//                     }

//                     return calendarEventList.isNotEmpty
//                         ? ListView.builder(
//                             scrollDirection: Axis.horizontal,
//                             itemCount: todayEventList.length,
//                             itemBuilder: (context, index) {
//                               CalendarEvent todayEvent = todayEventList[index];
//                               List<DayOfProgram> dayOfProgramList =
//                                   todayEvent.dayProgram;
//                               print(index);
//                               return Row(
//                                 children: dayOfProgramList.map((dayOfProgram) {
//                                   return InkWell(
//                                     onTap: () async {
//                                       final youtubeUrl = Uri.parse(
//                                           dayOfProgram.youtubeVid!.url!);
//                                       await launchUrl(youtubeUrl);
//                                     },
//                                     child: Padding(
//                                       padding:
//                                           const EdgeInsets.only(right: 8.0),
//                                       child: Stack(
//                                         children: [
//                                           Container(
//                                             width: 180,
//                                             child: ClipRRect(
//                                               borderRadius:
//                                                   BorderRadius.circular(7),
//                                               child: Image.network(
//                                                 dayOfProgram
//                                                     .youtubeVid!.thumbnail!,
//                                                 fit: BoxFit.cover,
//                                               ),
//                                             ),
//                                           ),
//                                           Container(
//                                             decoration: BoxDecoration(
//                                               borderRadius:
//                                                   BorderRadius.circular(10),
//                                               gradient: LinearGradient(
//                                                 begin: Alignment.bottomCenter,
//                                                 end: Alignment.topCenter,
//                                                 colors: <Color>[
//                                                   Colors.black54,
//                                                   Colors.transparent
//                                                 ],
//                                               ),
//                                             ),
//                                             width: 180,
//                                             height: 200,
//                                           ),
//                                           Positioned(
//                                             bottom: 6,
//                                             left: 6,
//                                             child: Text(
//                                               "Day ${dayOfProgram.numberOfDay}/${dayOfProgram.program!.totalDays}",
//                                               style: TextStyle(
//                                                   color: Colors.white,
//                                                   fontSize: 20),
//                                             ),
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                   );
//                                 }).toList(),
//                               );
//                             },
//                           )
//                         : Center(child: Text('Today is rest day!'));
//                   },
//                 ),
//               ),
//               SizedBox(height: 20),
//               Align(
//                 alignment: Alignment.topLeft,
//                 child: Text('Weight Training Programs',
//                     style: GoogleFonts.prompt(
//                       textStyle: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     )),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Container(
//                   height: 125,
//                   child: FutureBuilder(
//                     future: _programRepo.getSuggestPrograms(),
//                     builder: (context, snapshot) {
//                       return snapshot.hasData
//                           ? ListView.builder(
//                               itemCount: snapshot.data!.length,
//                               scrollDirection: Axis.horizontal,
//                               itemBuilder: (context, index) {
//                                 var program = snapshot.data![index] as Program;
//                                 return Padding(
//                                   padding: const EdgeInsets.only(right: 8.0),
//                                   child: InkWell(
//                                     onTap: (() {
//                                       programProvider
//                                           .setProgramName(program.programName!);
//                                       Navigator.push(context,
//                                           MaterialPageRoute(builder: (context) {
//                                         return ShowAddProgramPage();
//                                       }));
//                                     }),
//                                     child: Stack(
//                                       children: [
//                                         Container(
//                                           width: 225,
//                                           child: ClipRRect(
//                                             borderRadius:
//                                                 BorderRadius.circular(7),
//                                             child: Image.network(
//                                               program.thumbnail!,
//                                               fit: BoxFit.cover,
//                                             ),
//                                           ),
//                                         ),
//                                         Container(
//                                           decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(10),
//                                             gradient: LinearGradient(
//                                               begin: Alignment.bottomCenter,
//                                               end: Alignment.topCenter,
//                                               colors: <Color>[
//                                                 Colors.black54,
//                                                 Colors.transparent
//                                               ],
//                                             ),
//                                           ),
//                                           width: 225,
//                                           height: 125,
//                                         ),
//                                         Positioned(
//                                           bottom: 6,
//                                           left: 6,
//                                           child: Text(
//                                             "${program.programName}",
//                                             style: TextStyle(
//                                                 color: Colors.white,
//                                                 fontSize: 20),
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                 );
//                               },
//                             )
//                           : Container();
//                     },
//                   )),
//               SizedBox(height: 20),
//               Align(
//                 alignment: Alignment.topLeft,
//                 child: Text('Body Weight Programs',
//                     style: GoogleFonts.prompt(
//                       textStyle: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     )),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Container(
//                   height: 125,
//                   child: FutureBuilder(
//                     future: bodyWeightProgram(),
//                     builder: (context, snapshot) {
//                       return snapshot.hasData
//                           ? ListView.builder(
//                               itemCount: snapshot.data!.length,
//                               scrollDirection: Axis.horizontal,
//                               itemBuilder: (context, index) {
//                                 var program = snapshot.data![index] as Program;
//                                 return Padding(
//                                   padding: const EdgeInsets.only(right: 8.0),
//                                   child: InkWell(
//                                     onTap: (() {}),
//                                     child: Stack(
//                                       children: [
//                                         Container(
//                                           width: 225,
//                                           child: ClipRRect(
//                                             borderRadius:
//                                                 BorderRadius.circular(7),
//                                             child: Image.network(
//                                               program.thumbnail!,
//                                               fit: BoxFit.cover,
//                                             ),
//                                           ),
//                                         ),
//                                         Container(
//                                           decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(10),
//                                             gradient: LinearGradient(
//                                               begin: Alignment.bottomCenter,
//                                               end: Alignment.topCenter,
//                                               colors: <Color>[
//                                                 Colors.black54,
//                                                 Colors.transparent
//                                               ],
//                                             ),
//                                           ),
//                                           width: 225,
//                                           height: 125,
//                                         ),
//                                         Positioned(
//                                           bottom: 6,
//                                           left: 6,
//                                           child: Text(
//                                             "${program.programName}",
//                                             style: TextStyle(
//                                                 color: Colors.white,
//                                                 fontSize: 20),
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                 );
//                               },
//                             )
//                           : Container();
//                     },
//                   )),
//               SizedBox(height: 20),
//               Align(
//                 alignment: Alignment.topLeft,
//                 child: Text('Cardio Programs',
//                     style: GoogleFonts.prompt(
//                       textStyle: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     )),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Container(
//                   height: 125,
//                   child: FutureBuilder(
//                     future: cardioProgram(),
//                     builder: (context, snapshot) {
//                       return snapshot.hasData
//                           ? ListView.builder(
//                               itemCount: snapshot.data!.length,
//                               scrollDirection: Axis.horizontal,
//                               itemBuilder: (context, index) {
//                                 var program = snapshot.data![index] as Program;
//                                 return Padding(
//                                   padding: const EdgeInsets.only(right: 8.0),
//                                   child: InkWell(
//                                     onTap: (() {}),
//                                     child: Stack(
//                                       children: [
//                                         Container(
//                                           width: 225,
//                                           child: ClipRRect(
//                                             borderRadius:
//                                                 BorderRadius.circular(7),
//                                             child: Image.network(
//                                               program.thumbnail!,
//                                               fit: BoxFit.cover,
//                                             ),
//                                           ),
//                                         ),
//                                         Container(
//                                           decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(10),
//                                             gradient: LinearGradient(
//                                               begin: Alignment.bottomCenter,
//                                               end: Alignment.topCenter,
//                                               colors: <Color>[
//                                                 Colors.black54,
//                                                 Colors.transparent
//                                               ],
//                                             ),
//                                           ),
//                                           width: 225,
//                                           height: 125,
//                                         ),
//                                         Positioned(
//                                           bottom: 6,
//                                           left: 6,
//                                           child: Text(
//                                             "${program.programName}",
//                                             style: TextStyle(
//                                                 color: Colors.white,
//                                                 fontSize: 20),
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                 );
//                               },
//                             )
//                           : Container();
//                     },
//                   )),
//             ],
//             // ),
//           ),
//         ),
//       ),
//     ));
//   }

//   Widget buildCard() => Container(
//         padding: EdgeInsets.all(100),
//         decoration: BoxDecoration(
//             color: Colors.red, borderRadius: BorderRadius.circular(12)),
//       );
// }
