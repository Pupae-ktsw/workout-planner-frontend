import 'dart:convert';
import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_custom_selector/widget/flutter_single_select.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/controllers/program_controller.dart';
import 'package:frontend/models/program.dart';
import 'package:frontend/repositories/program_repo.dart';
import 'package:frontend/views/dayOfProgramManage_page.dart';
import 'package:frontend/views/manageProgram_page.dart';
import 'package:frontend/views/program_page.dart';
import 'package:frontend/views/search_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../provider/programProvider.dart';

class ShowAddProgramPage extends StatefulWidget {
  const ShowAddProgramPage({super.key});
  @override
  _AddProgramPageState createState() => _AddProgramPageState();
}

class _AddProgramPageState extends State<ShowAddProgramPage> {
  final _retitionList = ["Weekly", "Daily"];
  String _repeatType = "Weekly"; //repeatType
  final _dailyList = [1, 2, 3, 4, 5, 6, 7];
  int? _repeatDaily; //repeatDaily
  bool? _isReminder = false; //isReminder
  DateTime _startDate = DateTime.now(); //startDate
  Color _color = Colors.red; //color
  TimeOfDay _workoutTime = const TimeOfDay(hour: 10, minute: 30); //workoutTime
  List<int>? _repeatWeekly = []; //repeatWeekly
  TextEditingController _programNameController =
      TextEditingController(); //programName
  int? _remindAf, _remindBf;
  int numberOfVideo = 0;

  List<StartEndDate> _startEndDate = [];
  List<Map<String, dynamic>> _optionsDays = [
    {"dayValue": 0, "day": 'S'},
    {"dayValue": 1, "day": 'M'},
    {"dayValue": 2, "day": 'T'},
    {"dayValue": 3, "day": 'W'},
    {"dayValue": 4, "day": 'TH'},
    {"dayValue": 5, "day": 'F'},
    {"dayValue": 6, "day": 'SA'}
  ];
  User thisUser = User();
  Program? thisProgram = Program();
  ProgramController programController = ProgramController(ProgramRepo());

  @override
  void initState() {
    super.initState();
    loadData();
    // thisProgram?.programName = "test test";
    // print(thisProgram?.programName ?? "programName : null");
  }

  Future<void> loadData() async {
    const storage = FlutterSecureStorage();
    String? userJson = await storage.read(key: 'user');
    User user = User.fromJson(json.decode(userJson!));
    setState(() {
      thisUser = user;
    });
  }

  Future pickColor() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0),
              ),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    BlockPicker(
                      pickerColor: _color,
                      onColorChanged: (color) {
                        setState(() {
                          _color = color;
                        });
                      },
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "OK",
                          style: GoogleFonts.prompt(
                            fontSize: 16,
                          ),
                        ))
                  ],
                ),
              ),
            ));
  }

  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime(2025))
        .then((value) => setState(() {
              _startDate = value ?? DateTime.now();
              _startEndDate.add(StartEndDate(startDate: value));
            }));
  }

  @override
  Widget build(BuildContext context) {
    //Provider
    var programProvider = Provider.of<ProgramProvider>(context, listen: false);
    final hours = _workoutTime.hour.toString().padLeft(2, '0');
    final minutes = _workoutTime.minute.toString().padLeft(2, '0');
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
          padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
          child: SafeArea(
              child: SingleChildScrollView(
                  child: Column(
            children: [
              Container(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text("Add / Edit Program",
                      style: GoogleFonts.prompt(
                        fontSize: 32,
                      )),
                ),
              ),
              const SizedBox(height: 10),
              // Container(
              //   child: Align(
              //     alignment: Alignment.topLeft,
              //     child: Text('Program Name',
              //         style: GoogleFonts.prompt(
              //           fontSize: 20,
              //         )),
              //   ),
              // ),
              const SizedBox(height: 10),
              Container(
                height: 26,
                width: 270,
                child: TextFormField(
                  cursorHeight: 18,
                  onChanged: (value) {
                    setState(() {
                      _programNameController.text = value;
                      programProvider.setProgramName(value);
                    });
                  },
                  style: TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 10, top: 5),
                    hintText: "Progran name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 150,
                width: 260,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[200],
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(7),
                    child: programProvider.thumbnail != null
                        ? Stack(
                            children: [
                              Image.network(programProvider.thumbnail!,
                                  fit: BoxFit.cover),
                              Container(
                                  height: 150,
                                  width: 260,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: <Color>[
                                        Colors.black54,
                                        Colors.transparent
                                      ],
                                    ),
                                  ))
                            ],
                          )
                        : Container(
                            height: 150,
                            width: 260,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey[200],
                            ))),
              ),
              const SizedBox(height: 10),
              Text(
                programProvider.programName!,
                style: GoogleFonts.prompt(
                    textStyle:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
              ),
              Text('(${programProvider.dayofProgramList.length} videos)',
                  style: GoogleFonts.prompt(
                    textStyle: TextStyle(fontSize: 16),
                  )),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DayOfProgramManage()),
                  );
                },
                child: Text(
                  'Customize/Add Video',
                  style: GoogleFonts.prompt(
                      textStyle: Theme.of(context).textTheme.bodyText1,
                      color: Colors.blue,
                      fontSize: 18),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Repetition',
                      style: GoogleFonts.prompt(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(width: 10),
                  SizedBox(
                      width: 80,
                      child: DropdownButtonFormField(
                        value: programProvider.repeatType,
                        items: _retitionList
                            .map(((e) => DropdownMenuItem(
                                  child: Text(e),
                                  value: e,
                                )))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _repeatType = value as String;
                            programProvider.setRepeatType(_repeatType);
                          });
                        },
                      )),
                ],
              ),
              const SizedBox(height: 10),
              Visibility(
                visible: programProvider.repeatType == "Weekly",
                child: Container(
                  height: 50,
                  width: double.infinity,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: _optionsDays.length,
                        itemBuilder: (BuildContext context, int index) {
                          final option = _optionsDays[index];
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                if (_repeatWeekly!
                                    .contains(option['dayValue'])) {
                                  _repeatWeekly!.remove(option['dayValue']);
                                } else {
                                  _repeatWeekly!.add(option['dayValue']);
                                }
                                _repeatWeekly!.sort();
                                programProvider.setRepeatWeekly(_repeatWeekly!);

                                print(_repeatWeekly.toString());
                              });
                            },
                            child: Row(
                              children: [
                                Container(
                                    margin: const EdgeInsets.all(3.0),
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                        color: programProvider.repeatWeekly!
                                                .contains(option['dayValue'])
                                            ? Colors.red
                                            : Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        border: Border.all(
                                            width: 2,
                                            color: programProvider.repeatWeekly!
                                                    .contains(
                                                        option['dayValue'])
                                                ? Colors.red
                                                : Colors.black)),
                                    child: Text(
                                      option['day'],
                                      style: GoogleFonts.prompt(
                                        color: programProvider.repeatWeekly!
                                                .contains(option['dayValue'])
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )),
                                SizedBox(width: 10)
                              ],
                            ),
                          );
                        }),
                  ),
                ),
              ),
              Visibility(
                visible: programProvider.repeatType == "Daily",
                child: Row(
                  children: [
                    Text('Daily',
                        style: GoogleFonts.prompt(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 50),
                    SizedBox(
                      width: 80,
                      child: DropdownButtonFormField(
                          value: programProvider.repeatDaily,
                          items: _dailyList
                              .map(((e) => DropdownMenuItem(
                                    child: Text(
                                      e.toString(),
                                      textAlign: TextAlign.center,
                                    ),
                                    value: e,
                                  )))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _repeatDaily = value as int;
                              programProvider.setRepeatDaily(value as int);
                            });
                          }),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text('Start Date',
                            style: GoogleFonts.prompt(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        const SizedBox(width: 10),
                        InkWell(
                          onTap: () {
                            // _showDatePicker;
                            // setState(() {
                            //   _startEndDate
                            //       .add(StartEndDate(startDate: DateTime.now()));
                            //   programProvider.setStartEndDate(_startEndDate);
                            // });
                            showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2019),
                                    lastDate: DateTime(2025))
                                .then((value) => setState(() {
                                      _startDate = value ?? DateTime.now();
                                      _startEndDate.add(
                                          StartEndDate(startDate: _startDate));
                                      programProvider
                                          .setStartEndDate(_startEndDate);
                                    }));
                            print(programProvider.startEndDate[0].startDate);
                          },
                          child: Container(
                            height: 25,
                            width: 110,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromARGB(255, 206, 203, 203),
                            ),
                            child: programProvider.startEndDate.isNotEmpty
                                ? Text(
                                    programProvider.startEndDate[0].startDate
                                        .toString(),
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.prompt(fontSize: 16))
                                : Text(DateTime.now().toString(),
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.prompt(fontSize: 16)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text('Time',
                            style: GoogleFonts.prompt(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        const SizedBox(width: 50),
                        InkWell(
                          onTap: () async {
                            TimeOfDay? newTime = await showTimePicker(
                                context: context, initialTime: _workoutTime);
                            if (newTime == null) {
                              return;
                            }
                            setState(() {
                              _workoutTime = newTime;
                              // print(_workoutTime.toString());

                              programProvider.setWorkoutTime(
                                  "${_workoutTime.hour.toString().padLeft(2, '0')}:${_workoutTime.minute.toString().padLeft(2, '0')}");
                            });
                          },
                          child: Container(
                              height: 25,
                              width: 60,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10),
                                color: const Color.fromARGB(255, 206, 203, 203),
                              ),
                              child: programProvider.workoutTime != null
                                  ? Text(programProvider.workoutTime!,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.prompt(fontSize: 16))
                                  : Text("10:30",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.prompt(fontSize: 16))),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text('Color',
                            style: GoogleFonts.prompt(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        const SizedBox(width: 50),
                        InkWell(
                          onTap: () {
                            pickColor();
                            setState(() {
                              programProvider.setColor('0x' +
                                  _color.value.toRadixString(16).substring(2));
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _color,
                            ),
                            width: 20,
                            height: 20,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    ExpansionPanelList(
                      children: [
                        ExpansionPanel(
                            isExpanded: programProvider.isReminder == null
                                ? false
                                : programProvider.isReminder == false
                                    ? false
                                    : true,
                            headerBuilder:
                                (BuildContext context, bool isExpanded) {
                              return Container(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: [
                                      Checkbox(
                                          value: programProvider.isReminder,
                                          tristate: true,
                                          onChanged: (value) {
                                            setState(() {
                                              if (value == null) {
                                                // _isExpanded = false;

                                                programProvider
                                                    .setIsReminder(false);
                                              } else {
                                                // _isExpanded = true;

                                                programProvider
                                                    .setIsReminder(true);
                                              }
                                            });
                                          }),
                                      Text(
                                        'Remind me',
                                        style: GoogleFonts.prompt(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ));
                            },
                            body: Container(
                              padding: const EdgeInsets.only(left: 20),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text('Before Workout',
                                          style: GoogleFonts.prompt(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                      const SizedBox(width: 10),
                                      SizedBox(
                                        height: 30,
                                        width: 150,
                                        child: CustomSingleSelectField<String>(
                                          items: [
                                            "0 min",
                                            "10 mins",
                                            "30 mins",
                                            "60 mins",
                                          ],
                                          title: "Time",
                                          initialValue: programProvider.remindBf
                                                  .toString() +
                                              " mins",
                                          onSelectionDone: (value) {
                                            // selectedString = value;
                                            setState(() {
                                              if (value == "0 min") {
                                                _remindBf = 0;
                                                programProvider
                                                    .setRemindBf(_remindBf);
                                              } else if (value == "10 mins") {
                                                _remindBf = 10;
                                                programProvider
                                                    .setRemindBf(_remindBf);
                                              } else if (value == "30 mins") {
                                                _remindBf = 30;
                                                programProvider
                                                    .setRemindBf(_remindBf);
                                              } else {
                                                _remindBf = 60;
                                                programProvider
                                                    .setRemindBf(_remindBf);
                                              }
                                            });
                                          },
                                          itemAsString: (item) => item,
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Text(
                                        'After Workout',
                                        style: GoogleFonts.prompt(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(width: 22),
                                      InkWell(
                                        onTap: () {},
                                        child: SizedBox(
                                            height: 30,
                                            width: 150,
                                            child:
                                                CustomSingleSelectField<String>(
                                              items: [
                                                "30 min",
                                                "45 mins",
                                                "60 mins",
                                                "90 mins",
                                                "120 mins",
                                                "180 mins"
                                              ],
                                              title: "Time",
                                              initialValue: programProvider
                                                      .remindAf
                                                      .toString() +
                                                  " mins",
                                              onSelectionDone: (value) {
                                                // selectedString = value;
                                                setState(() {
                                                  if (value == "30 min") {
                                                    _remindAf = 30;
                                                    programProvider
                                                        .setRemindAf(_remindAf);
                                                  } else if (value ==
                                                      "45 mins") {
                                                    _remindAf = 45;
                                                    programProvider
                                                        .setRemindAf(_remindAf);
                                                  } else if (value ==
                                                      "60 mins") {
                                                    _remindAf = 60;
                                                    programProvider
                                                        .setRemindAf(_remindAf);
                                                  } else if (value ==
                                                      "90 mins") {
                                                    _remindAf = 90;
                                                    programProvider
                                                        .setRemindAf(_remindAf);
                                                  } else if (value ==
                                                      "120 mins") {
                                                    _remindAf = 120;
                                                    programProvider
                                                        .setRemindAf(_remindAf);
                                                  } else {
                                                    _remindAf = 180;
                                                    programProvider
                                                        .setRemindAf(_remindAf);
                                                  }
                                                });
                                              },
                                              itemAsString: (item) => item,
                                            )),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            )),
                      ],
                    ),
                    const SizedBox(height: 5),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.white),
                          onPressed: () {
                            setState(() {
                              programProvider.programName = "Program name";
                              programProvider.thumbnail = null;
                              // programProvider.setColor();
                              programProvider.setWorkoutTime("10:30");
                              programProvider.setIsReminder(false);
                              programProvider.setRepeatType("Weekly");
                              programProvider.setRepeatDaily(1);
                              programProvider.setRepeatWeekly([]);
                              programProvider.setRemindAf(30);
                              programProvider.setRemindBf(0);
                              programProvider.setStartEndDate([]);
                              programProvider.setDayOfProgramList([]);
                              programProvider.setshuffleIndex(0);
                              programProvider.setNumberOfDay(1);
                            });

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProgramPage()));
                          },
                          child: const Text(
                            "CANCEL",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black),
                            onPressed: () {
                              Program sendProgram = Program(
                                programName: programProvider.programName,
                                color: programProvider.color,
                                workoutTime: programProvider.workoutTime,
                                isReminder: programProvider.isReminder,
                                repeatType: programProvider.repeatType,
                                repeatDaily: programProvider.repeatDaily,
                                repeatWeekly: programProvider.repeatWeekly,
                                remindAf: programProvider.remindAf,
                                remindBf: programProvider.remindBf,
                                startEndDate: programProvider.startEndDate,
                                dayofProgram: programProvider.dayofProgramList,
                              );
                              programController.postProgram(sendProgram);
                              setState(() {
                                programProvider.setProgramName("Program name");
                                programProvider.setThumbnail("");
                                // programProvider.setColor();
                                programProvider.setWorkoutTime("10:30");
                                programProvider.setIsReminder(false);
                                programProvider.setRepeatType("Weekly");
                                programProvider.setRepeatDaily(1);
                                programProvider.setRepeatWeekly([]);
                                programProvider.setRemindAf(30);
                                programProvider.setRemindBf(0);
                                programProvider.setStartEndDate([]);
                                programProvider.setDayOfProgramList([]);
                                programProvider.setshuffleIndex(0);
                                programProvider.setNumberOfDay(1);
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProgramPage()));
                            },
                            child: const Text(
                              "SAVE",
                              style: TextStyle(color: Colors.white),
                            ))
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          )))),
    );
  }
}
