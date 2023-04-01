import 'package:flutter/material.dart';
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
    required this.youtubeVid,
  }) : super(key: key);

  final YoutubeVid youtubeVid;

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
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
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
                    child: Icon(
                      Icons.arrow_back,
                      size: 36,
                    ),
                  ),
                  Text(programProvider.programName!,
                      style: TextStyle(fontSize: 20)),
                  SizedBox(width: 40),
                ],
              ),
              // Row(
              //   children: [
              //     Text("${programProvider.dayofProgramList[0].numberOfDay}"),
              //     Text(
              //         "${programProvider.dayofProgramList[0].youtubeVid!.title}"),
              //   ],
              // )
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: programProvider.dayofProgramList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                  programProvider.setShuffleDay(index);
                                });
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SearchShufflePage(),
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
                        Row(
                          children: [
                            Expanded(
                                child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
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
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "${programProvider.dayofProgramList[index].youtubeVid!.title}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "${programProvider.dayofProgramList[index].youtubeVid!.channel}",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
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
                                builder: (context) => ShowAddProgramPage()));
                      }),
                      child: Text("Next")),
                  Container(
                    width: 20,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
