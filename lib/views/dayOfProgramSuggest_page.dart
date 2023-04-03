import 'package:flutter/material.dart';
import 'package:frontend/controllers/day_of_program_controller.dart';
import 'package:frontend/repositories/day_of_program_repo.dart';
import 'package:frontend/views/addProgram_page.dart';
import 'package:frontend/views/home_page.dart';
import 'package:provider/provider.dart';

import '../models/dayOfProgram.dart';
import '../provider/programProvider.dart';

class DayOfSuggestPage extends StatefulWidget {
  const DayOfSuggestPage({super.key});

  @override
  State<DayOfSuggestPage> createState() => _DayOfSuggestPageState();
}

class _DayOfSuggestPageState extends State<DayOfSuggestPage> {
  DayOfProgramController dayOfProgramController =
      DayOfProgramController(DayOfProgramRepo());
  List<DayOfProgram> dayOfProgramSuggestList = [];
  @override
  Widget build(BuildContext context) {
    var programProvider = Provider.of<ProgramProvider>(context, listen: false);
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
                          MaterialPageRoute(builder: (context) => Homepage()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 36,
                      ),
                    )),
                Text('${programProvider.programName}',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                Container(
                  width: 20,
                )
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 16, top: 10, right: 16),
                child: FutureBuilder<List<Object>>(
                    future: dayOfProgramController
                        .getDayOfProgram(programProvider.id!),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        dayOfProgramSuggestList =
                            snapshot.data! as List<DayOfProgram>;
                      }
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

                                return snapshot.hasData
                                    ? Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 15.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                dayOfProgram.workoutStatus ==
                                                        "Done"
                                                    ? Icon(
                                                        Icons
                                                            .check_circle_outline,
                                                        color: Colors.green)
                                                    : Container(),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: Image.network(
                                                      dayOfProgram.youtubeVid!
                                                              .thumbnail ??
                                                          "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.pinterest.com%",
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                  child: Column(children: [
                                                    Align(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Text(
                                                        dayOfProgram.youtubeVid!
                                                                .title ??
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
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Text(
                                                        dayOfProgram.youtubeVid!
                                                                .channel ??
                                                            "No program",
                                                      ),
                                                    ),
                                                  ]),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    : Center(
                                        child: CircularProgressIndicator(),
                                      );
                              },
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0))),
                                onPressed: (() {
                                  programProvider.setDayOfProgramList(
                                      dayOfProgramSuggestList);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ShowAddProgramPage()));
                                }),
                                child: Text("Add Program"))
                          ],
                        ),
                      );
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
