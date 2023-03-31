import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:frontend/controllers/day_of_program_controller.dart';
import 'package:frontend/controllers/program_controller.dart';
import 'package:frontend/models/dayOfProgram.dart';
import 'package:frontend/repositories/day_of_program_repo.dart';
import 'package:frontend/repositories/program_repo.dart';
import 'package:frontend/views/program_page.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/program.dart';

class DayOfProgramPage extends StatelessWidget {
  const DayOfProgramPage({super.key, required this.program});

  final Program program;

  @override
  Widget build(BuildContext context) {
    Program? programById;
    ProgramController programController = ProgramController(ProgramRepo());

    DayOfProgramController dayOfProgramController =
        DayOfProgramController(DayOfProgramRepo());
    dayOfProgramController.getDayOfProgram(program.id!);

    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ProgramPage()));
                  },
                  child: Icon(
                    Icons.arrow_back,
                    size: 32,
                  )),
              Text('${program.programName}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Container()
            ],
          ),
          SizedBox(height: 10),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 16, top: 10, right: 16),
              child: FutureBuilder<List<Object>>(
                  future: dayOfProgramController.getDayOfProgram(program.id!),
                  builder: (context, snapshot) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data?.length ?? 0,
                            itemBuilder: (context, index) {
                              var dayOfProgram =
                                  snapshot.data![index] as DayOfProgram;
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Day' +
                                          ' ' +
                                          '${dayOfProgram.numberOfDay}',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Stack(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Image.network(
                                                  dayOfProgram.youtubeVid!
                                                          .thumbnail ??
                                                      "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.pinterest.com%",
                                                ),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: dayOfProgram
                                                              .workoutStatus ==
                                                          "Done"
                                                      ? Colors.black
                                                          .withOpacity(0.47)
                                                      : Colors.black
                                                          .withOpacity(0),
                                                ),
                                                child: SizedBox(
                                                  height: 100,
                                                  width: 200,
                                                ),
                                              ),
                                              Positioned(
                                                top: 32,
                                                left: 62,
                                                child: BorderedText(
                                                  strokeWidth: 3,
                                                  strokeColor: Colors.black,
                                                  child: dayOfProgram
                                                              .workoutStatus ==
                                                          "Done"
                                                      ? Text(
                                                          dayOfProgram
                                                              .workoutStatus!,
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              color:
                                                                  Colors.white),
                                                        )
                                                      : Text(''),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Column(children: [
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                dayOfProgram
                                                        .youtubeVid!.title ??
                                                    "No program",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                dayOfProgram
                                                        .youtubeVid!.channel ??
                                                    "No program",
                                              ),
                                            ),
                                          ]),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          )
        ],
      )),
    );
  }
}
