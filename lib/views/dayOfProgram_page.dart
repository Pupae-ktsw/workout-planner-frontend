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
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
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
                    return Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data?.length ?? 0,
                              itemBuilder: (context, index) {
                                var dayOfProgram =
                                    snapshot.data![index] as DayOfProgram;
                                return Column(
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
                                    ListView.builder(
                                      physics: ClampingScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: dayOfProgram.workouts!.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          width: 140,
                                          child: Row(
                                            children: [
                                              Container(
                                                height: 130,
                                                width: 160,
                                                child: Image.network(
                                                  dayOfProgram
                                                          .workouts![index]
                                                          .youtubeVid!
                                                          .thumbnail ??
                                                      "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.pinterest.com%",
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Column(children: [
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(
                                                      dayOfProgram
                                                              .workouts![index]
                                                              .youtubeVid!
                                                              .title ??
                                                          "No program",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(
                                                      dayOfProgram
                                                              .workouts![index]
                                                              .youtubeVid!
                                                              .channel ??
                                                          "No program",
                                                    ),
                                                  ),
                                                ]),
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
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
