import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_custom_selector/widget/flutter_single_select.dart';
import 'package:frontend/views/manageProgram_page.dart';
import 'package:frontend/views/program_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class showAddProgramPage extends StatefulWidget {
  const showAddProgramPage({super.key});
  @override
  _AddProgramPageState createState() => _AddProgramPageState();
}

class _AddProgramPageState extends State<showAddProgramPage> {
  final _retitionList = ["Weekly", "Daily"];
  String _selectedRetition = "Weekly";
  final _dailyList = ["1", "2", "3", "4", "5", "6", "7"];
  String _selectDaily = "1";
  bool? _isChecked = false;
  DateTime _dateTime = DateTime.now();
  Color colorPick = Colors.red;
  Color currentColor = Colors.red;
  TimeOfDay _time = const TimeOfDay(hour: 10, minute: 30);
  List<String> _selectedOptionsDays = [];

  List<String> _optionsDays = ['M', 'T', 'W', 'TH', 'F', 'SA', 'S'];

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
                      pickerColor: colorPick,
                      onColorChanged: (color) {
                        setState(() {
                          colorPick = color;
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
              _dateTime = value ?? DateTime.now();
            }));
  }

  // void pickTime() {}

  @override
  Widget build(BuildContext context) {
    final hours = _time.hour.toString().padLeft(2, '0');
    final minutes = _time.minute.toString().padLeft(2, '0');
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
                height: 30,
                child: TextField(
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
                child: Image.network(
                    'http://i3.ytimg.com/vi/2MoGxae-zyo/hqdefault.jpg',
                    fit: BoxFit.cover),
              ),
              const SizedBox(height: 10),
              Text(
                'Epic Endgame',
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
                        value: _selectedRetition,
                        items: _retitionList
                            .map(((e) => DropdownMenuItem(
                                  child: Text(e),
                                  value: e,
                                )))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedRetition = value as String;
                          });
                        },
                      )),
                ],
              ),
              const SizedBox(height: 10),
              Visibility(
                visible: _selectedRetition == "Weekly",
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
                                if (_selectedOptionsDays.contains(option)) {
                                  _selectedOptionsDays.remove(option);
                                } else {
                                  _selectedOptionsDays.add(option);
                                }
                              });
                            },
                            child: Row(
                              children: [
                                Container(
                                    margin: const EdgeInsets.all(3.0),
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                        color: _selectedOptionsDays
                                                .contains(option)
                                            ? Colors.red
                                            : Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        border: Border.all(
                                            width: 2,
                                            color: _selectedOptionsDays
                                                    .contains(option)
                                                ? Colors.red
                                                : Colors.black)),
                                    child: Text(
                                      _optionsDays[index],
                                      style: GoogleFonts.prompt(
                                        color: _selectedOptionsDays
                                                .contains(option)
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
                visible: _selectedRetition == "Daily",
                child: Row(
                  children: [
                    Text('Daily',
                        style: GoogleFonts.prompt(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 50),
                    SizedBox(
                      width: 80,
                      child: DropdownButtonFormField(
                          value: _selectDaily,
                          items: _dailyList
                              .map(((e) => DropdownMenuItem(
                                    child: Text(
                                      e,
                                      textAlign: TextAlign.center,
                                    ),
                                    value: e,
                                  )))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectDaily = value as String;
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
                            width: 120,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromARGB(255, 206, 203, 203),
                            ),
                            child: Text(_dateTime.toString(),
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
                                context: context, initialTime: _time);
                            if (newTime == null) {
                              return;
                            }
                            setState(() {
                              _time = newTime;
                            });
                          },
                          child: Container(
                            height: 25,
                            width: 80,
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
                              color: colorPick,
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
                            isExpanded: _isChecked == null
                                ? false
                                : _isChecked == false
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
                                          value: _isChecked,
                                          tristate: true,
                                          onChanged: (value) {
                                            setState(() {
                                              if (value == null) {
                                                // _isExpanded = false;
                                                _isChecked = false;
                                              } else {
                                                // _isExpanded = true;
                                                _isChecked = true;
                                              }
                                              debugPrint(_isChecked.toString());
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
                                          items: ['15 min', '30 min'],
                                          title: "Time",
                                          onSelectionDone: (value) {
                                            // selectedString = value;
                                            setState(() {});
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
                                              items: ['15 min', '30 min'],
                                              title: "Time",
                                              onSelectionDone: (value) {
                                                // selectedString = value;
                                                setState(() {});
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
                            onPressed: () {},
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
