import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:frontend/models/dayOfProgram.dart';
import 'package:frontend/models/youtubeVid.dart';
import 'package:frontend/views/addProgram_page.dart';
import 'package:frontend/views/program_page.dart';
import 'package:frontend/views/search_for_shuffle_page.dart';
import 'package:frontend/views/search_page.dart';
import 'package:provider/provider.dart';

import '../provider/programProvider.dart';

class DayOfProgramManage extends StatefulWidget {
  const DayOfProgramManage({
    Key? key,
  });

  @override
  State<DayOfProgramManage> createState() => _DayOfProgramManageState();
}

class _DayOfProgramManageState extends State<DayOfProgramManage> {
  List<DayOfProgram> _dayOfProgramList = [];

  @override
  Widget build(BuildContext context) {
    var programProvider = Provider.of<ProgramProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShowAddProgramPage(),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 36,
                    ),
                  ),
                ),
                Text(programProvider.programName!,
                    style: TextStyle(fontSize: 18)),
                SizedBox(width: 40),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: programProvider.dayofProgramList.length,
                          itemBuilder: (context, index) {
                            return programProvider.dayofProgramList.length > 0
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(width: 10),
                                            Text(
                                              "Day ${programProvider.dayofProgramList[index].numberOfDay}",
                                              style: TextStyle(fontSize: 18),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  programProvider
                                                      .setShuffleDay(index);
                                                });
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        SearchShufflePage(),
                                                  ),
                                                );
                                              },
                                              child: Icon(
                                                Icons.swap_horiz_rounded,
                                                color: Colors.blue,
                                                size: 32,
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Slidable(
                                          endActionPane: ActionPane(
                                            motion: const ScrollMotion(),
                                            children: [
                                              SlidableAction(
                                                  backgroundColor: Colors.red,
                                                  icon: Icons
                                                      .delete_forever_rounded,
                                                  onPressed: (context) =>
                                                      programProvider
                                                          .removeDayOfProgram(
                                                              index)),
                                            ],
                                          ),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                child: Image.network(
                                                  "${programProvider.dayofProgramList[index].youtubeVid!.thumbnail}",
                                                  fit: BoxFit.cover,
                                                ),
                                              )),
                                              SizedBox(width: 10),
                                              Expanded(
                                                child: Column(
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Text(
                                                        "${programProvider.dayofProgramList[index].youtubeVid!.title}",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    SizedBox(height: 5),
                                                    Align(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Text(
                                                        "${programProvider.dayofProgramList[index].youtubeVid!.channel}",
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Center(child: Text('Add Day of Program'));
                          },
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SearchPage(),
                          ),
                        );
                      },
                      child: Icon(
                        Icons.add_circle,
                        size: 36,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 20,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black54,
                            ),
                            onPressed: (() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProgramPage()));
                              setState(() {
                                programProvider.setProgramName("Program name");
                                programProvider.setshuffleIndex(0);
                                programProvider.setNumberOfDay(1);
                                programProvider.setRepeatType("Weekly");
                                programProvider.setDayOfProgramList([]);
                                programProvider.setStartEndDate([]);
                                programProvider.setRemindAf(0);
                                programProvider.setRemindBf(30);
                                programProvider.setRepeatDaily(null);
                                programProvider.setRepeatWeekly([]);
                                programProvider.setIsReminder(false);
                                programProvider.thumbnail = null;
                              });
                            }),
                            child: Text(
                              "Cancel",
                              style: TextStyle(color: Colors.white),
                            )),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            onPressed: (() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ShowAddProgramPage()));
                            }),
                            child: Text("Next")),
                        Container(
                          width: 20,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
