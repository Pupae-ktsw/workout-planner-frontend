import 'dart:convert';
import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_custom_selector/widget/flutter_single_select.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/controllers/program_controller.dart';
import 'package:frontend/models/program.dart';
import 'package:frontend/repositories/program_repo.dart';
import 'package:frontend/views/manageProgram_page.dart';
import 'package:frontend/views/program_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../models/user.dart';

class showAddProgramPage extends StatefulWidget {
  const showAddProgramPage({super.key});
  @override
  _AddProgramPageState createState() => _AddProgramPageState();
}

class _AddProgramPageState extends State<showAddProgramPage> {
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
              Container(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text('Program Name',
                      style: GoogleFonts.prompt(
                        fontSize: 20,
                      )),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 26,
                child: TextFormField(
                  controller: _programNameController,
                  style: TextStyle(fontSize: 16),
                  decoration: InputDecoration(
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
                // child: Image.network(
                //     'http://i3.ytimg.com/vi/2MoGxae-zyo/hqdefault.jpg',
                //     fit: BoxFit.cover),
              ),
              const SizedBox(height: 10),
              Text(
                'Epic Heat',
                style: GoogleFonts.prompt(
                    textStyle: Theme.of(context).textTheme.bodyText1),
              ),
              Text('(10 videos)',
                  style: GoogleFonts.prompt(
                      textStyle: Theme.of(context).textTheme.bodyText1)),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => showManageProgram()),
                  );
                },
                child: Text(
                  'Customize/Select Video',
                  style: GoogleFonts.prompt(
                      textStyle: Theme.of(context).textTheme.bodyText1,
                      color: Colors.blue),
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
                        //   decoration: InputDecoration(
                        //     border: OutlineInputBorder(
                        //         borderRadius: BorderRadius.circular(15)),
                        //   ),
                        value: _repeatType,
                        items: _retitionList
                            .map(((e) => DropdownMenuItem(
                                  child: Text(e),
                                  value: e,
                                )))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _repeatType = value as String;
                          });
                        },
                      )),
                ],
              ),
              const SizedBox(height: 10),
              Visibility(
                visible: _repeatType == "Weekly",
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

                                print(_repeatWeekly.toString());
                              });
                            },
                            child: Row(
                              children: [
                                Container(
                                    margin: const EdgeInsets.all(3.0),
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                        color: _repeatWeekly!
                                                .contains(option['dayValue'])
                                            ? Colors.red
                                            : Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        border: Border.all(
                                            width: 2,
                                            color: _repeatWeekly!.contains(
                                                    option['dayValue'])
                                                ? Colors.red
                                                : Colors.black)),
                                    child: Text(
                                      option['day'],
                                      style: GoogleFonts.prompt(
                                        color: _repeatWeekly!
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
                visible: _repeatType == "Daily",
                child: Row(
                  children: [
                    Text('Daily',
                        style: GoogleFonts.prompt(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 50),
                    SizedBox(
                      width: 80,
                      child: DropdownButtonFormField(
                          value: _repeatDaily,
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
                          onTap: _showDatePicker,
                          child: Container(
                            height: 25,
                            width: 110,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromARGB(255, 206, 203, 203),
                            ),
                            child: Text(_startDate.toString(),
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
                            child: Text('${hours}:${minutes}',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.prompt(fontSize: 16)),
                          ),
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
                      // expansionCallback: (int index, bool status) {
                      //   setState(() {
                      //     if (status) {
                      //       _isExpanded = !status;
                      //     } else {
                      //       _isExpanded = true;
                      //     }
                      //   });
                      // },
                      children: [
                        ExpansionPanel(
                            isExpanded: _isReminder == null
                                ? false
                                : _isReminder == false
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
                                          value: _isReminder,
                                          tristate: true,
                                          onChanged: (value) {
                                            setState(() {
                                              if (value == null) {
                                                // _isExpanded = false;
                                                _isReminder = false;
                                              } else {
                                                // _isExpanded = true;
                                                _isReminder = true;
                                              }
                                              debugPrint(
                                                  _isReminder.toString());
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
                                          onSelectionDone: (value) {
                                            // selectedString = value;
                                            setState(() {
                                              if (value == "0 min") {
                                                _remindBf = 0;
                                              } else if (value == "10 mins") {
                                                _remindBf = 10;
                                              } else if (value == "30 mins") {
                                                _remindBf = 30;
                                              } else {
                                                _remindBf = 60;
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
                                                "0 min",
                                                "10 mins",
                                                "30 mins",
                                                "60 mins",
                                                "120 mins",
                                                "180 mins"
                                              ],
                                              title: "Time",
                                              onSelectionDone: (value) {
                                                // selectedString = value;
                                                setState(() {
                                                  if (value == "0 min") {
                                                    _remindAf = 0;
                                                  } else if (value ==
                                                      "10 mins") {
                                                    _remindAf = 10;
                                                  } else if (value ==
                                                      "30 mins") {
                                                    _remindAf = 30;
                                                  } else if (value ==
                                                      "60 mins") {
                                                    _remindAf = 60;
                                                  } else if (value ==
                                                      "120 mins") {
                                                    _remindAf = 120;
                                                  } else {
                                                    _remindAf = 180;
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
                                programName: _programNameController.text,
                                color:
                                    _color.value.toRadixString(16).substring(2),
                                workoutTime: '$hours:$minutes',
                                isReminder: _isReminder,
                                repeatType: _repeatType,
                                repeatDaily: _repeatDaily,
                                repeatWeekly: _repeatWeekly,
                                remindAf: _remindAf,
                                remindBf: _remindBf,
                                startEndDate: _startEndDate,
                                totalDays: 7,
                              );
                              programController.postProgram(sendProgram);
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
