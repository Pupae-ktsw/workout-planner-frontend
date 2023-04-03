import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:frontend/controllers/day_of_program_controller.dart';
import 'package:frontend/controllers/program_controller.dart';
import 'package:frontend/models/dayOfProgram.dart';
import 'package:frontend/repositories/day_of_program_repo.dart';
import 'package:frontend/repositories/program_repo.dart';
import 'package:frontend/views/program_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

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
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 36,
                    ),
                  )),
              Text('${program.programName}',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              InkWell(
                onTap: () {
                  programController.deleteProgram(program.id!);

                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProgramPage()));
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Icon(Icons.delete_forever, size: 36),
                ),
              )
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

                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Day' +
                                              ' ' +
                                              '${dayOfProgram.numberOfDay}',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        dayOfProgram.workoutStatus == "Done"
                                            ? Icon(Icons.check_circle_outline,
                                                color: Colors.green)
                                            : Container(),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        final youtubeUrl = Uri.parse(
                                            dayOfProgram.youtubeVid!.url!);
                                        await launchUrl(youtubeUrl);
                                      },
                                      child: Row(
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
                                                        BorderRadius.circular(
                                                            10),
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
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  dayOfProgram.youtubeVid!
                                                          .channel ??
                                                      "No program",
                                                ),
                                              ),
                                            ]),
                                          )
                                        ],
                                      ),
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
