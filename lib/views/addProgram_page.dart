import 'dart:math';

import 'package:flutter/material.dart';
import 'package:frontend/views/program_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class addProgram extends StatelessWidget {
  const addProgram({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Add Program",
      home: showAddProgramPage(),
    );
  }
}

class showAddProgramPage extends StatefulWidget {
  const showAddProgramPage({super.key});
  @override
  _AddProgramPageState createState() => _AddProgramPageState();
}

class _AddProgramPageState extends State<showAddProgramPage> {
  final _retitionList = ["weekly", "everyday"];
  String _selectedValue = "weekly";
  bool? _isChecked = false;
  DateTime _dateTime = DateTime.now();
  Color colorPick = Colors.red;
  Color currentColor = Colors.red;
  TimeOfDay _time = TimeOfDay(hour: 10, minute: 30);
  List<String> _selectedOptionsDays = [];

  List<String> _optionsDays = ['M', 'T', 'W', 'T', 'F', 'S', 'SU'];

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
              _dateTime = value!;
            }));
  }

  @override
  Widget build(BuildContext context) {
    final hours = _time.hour.toString().padLeft(2, '0');
    final minutes = _time.minute.toString().padLeft(2, '0');
    return Scaffold(
      body: Container(
          padding: EdgeInsets.only(left: 16, top: 25, right: 16),
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
              SizedBox(height: 10),
              Container(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text('Program Name',
                      style: GoogleFonts.prompt(
                        fontSize: 20,
                      )),
                ),
              ),
              SizedBox(height: 10),
              InkWell(
                onTap: (() {}),
                child: Container(
                  height: 25,
                  width: 300,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromARGB(255, 206, 203, 203)),
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: 150,
                width: 260,
                child: Image.network(
                    'http://i3.ytimg.com/vi/2MoGxae-zyo/hqdefault.jpg',
                    fit: BoxFit.cover),
              ),
              SizedBox(height: 10),
              Text(
                'Epic Endgame',
                style: GoogleFonts.prompt(
                    textStyle: Theme.of(context).textTheme.bodyText1),
              ),
              Text('(10 videos)',
                  style: GoogleFonts.prompt(
                      textStyle: Theme.of(context).textTheme.bodyText1)),
              InkWell(
                onTap: () {},
                child: Text(
                  'Customize/Select Video',
                  style: GoogleFonts.prompt(
                      textStyle: Theme.of(context).textTheme.bodyText1,
                      color: Colors.blue),
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Repetition',
                      style: GoogleFonts.prompt(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(width: 10),
                  SizedBox(
                      width: 100,
                      child: DropdownButtonFormField(
                        //   decoration: InputDecoration(
                        //     border: OutlineInputBorder(
                        //         borderRadius: BorderRadius.circular(15)),
                        //   ),
                        value: _selectedValue,
                        items: _retitionList
                            .map(((e) => DropdownMenuItem(
                                  child: Text(e),
                                  value: e,
                                )))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedValue = value as String;
                          });
                        },
                      )),
                ],
              ),
              // Container(
              //   height: 150,
              //   child: ListView.builder(
              //       shrinkWrap: true,
              //       scrollDirection: Axis.horizontal,
              //       itemCount: _optionsDays.length,
              //       itemBuilder: (context, int index) {
              //         final option = _optionsDays[index];
              //         return GestureDetector(
              //           onTap: () {
              //             setState(() {
              //               if (_selectedOptionsDays.contains(option)) {
              //                 _selectedOptionsDays.remove(option);
              //               } else {
              //                 _selectedOptionsDays.add(option);
              //               }
              //             });
              //           },
              //           child: Container(
              //               margin: EdgeInsets.all(8.0),
              //               padding: EdgeInsets.all(8.0),
              //               decoration: BoxDecoration(
              //                 // color:
              //                 borderRadius: BorderRadius.circular(10),
              //               ),
              //               child: Text(
              //                 _selectedOptionsDays[index],
              //                 style: GoogleFonts.prompt(
              //                   color: _selectedOptionsDays.contains(option)
              //                       ? Colors.white
              //                       : Colors.black,
              //                   fontSize: 16,
              //                   fontWeight: FontWeight.bold,
              //                 ),
              //               )),
              //         );
              //       }),
              // ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text('Start Date',
                            style: GoogleFonts.prompt(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        SizedBox(width: 10),
                        InkWell(
                          onTap: _showDatePicker,
                          child: Container(
                            height: 25,
                            width: 120,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                              color: Color.fromARGB(255, 206, 203, 203),
                            ),
                            child: Text(_dateTime.toString(),
                                style: GoogleFonts.prompt(fontSize: 16)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text('Time',
                            style: GoogleFonts.prompt(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        SizedBox(width: 50),
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
                              color: Color.fromARGB(255, 206, 203, 203),
                            ),
                            child: Text('${hours}:${minutes}',
                                style: GoogleFonts.prompt(fontSize: 16)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text('Color',
                            style: GoogleFonts.prompt(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        SizedBox(width: 50),
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
                    SizedBox(height: 10),
                    Row(
                      children: [
                        // Checkbox(
                        //     value: _isChecked,
                        //     tristate: true,
                        //     onChanged: (value) {
                        //       setState(() {
                        //         _isChecked = value;
                        //       });
                        //     }),
                        // Text(
                        //   'Remind me',
                        //   style: GoogleFonts.prompt(
                        //       fontSize: 16, fontWeight: FontWeight.bold),
                        // ),
                        Expanded(
                          child: ExpansionTile(
                              title: Row(
                                children: [
                                  Checkbox(
                                      value: _isChecked,
                                      tristate: true,
                                      onChanged: (value) {
                                        setState(() {
                                          _isChecked = value;
                                        });
                                      }),
                                  Text(
                                    'Remind me',
                                    style: GoogleFonts.prompt(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text('Before Workout',
                                              style: GoogleFonts.prompt(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(width: 10),
                                          Container(
                                            height: 25,
                                            width: 50,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Color.fromARGB(
                                                  255, 206, 203, 203),
                                            ),
                                            child: Text('time',
                                                style: GoogleFonts.prompt(
                                                    fontSize: 16)),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Text(
                                            'After Workout',
                                            style: GoogleFonts.prompt(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(width: 22),
                                          InkWell(
                                            onTap: () {},
                                            child: Container(
                                              height: 25,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Color.fromARGB(
                                                    255, 206, 203, 203),
                                              ),
                                              child: Text('time',
                                                  style: GoogleFonts.prompt(
                                                      fontSize: 16)),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                    ],
                                  ),
                                )
                              ]),
                        )
                      ],
                    ),
                    const SizedBox(height: 5),
                    // Row(
                    //   children: [
                    //     Text('Before Workout',
                    //         style: GoogleFonts.prompt(
                    //             fontSize: 16, fontWeight: FontWeight.bold)),
                    //     SizedBox(width: 10),
                    //     InkWell(
                    //       onTap: () {},
                    //       child: Container(
                    //         height: 25,
                    //         width: 50,
                    //         decoration: BoxDecoration(
                    //           border: Border.all(color: Colors.grey),
                    //           borderRadius: BorderRadius.circular(10),
                    //           color: Color.fromARGB(255, 206, 203, 203),
                    //         ),
                    //         child: Text('time',
                    //             style: GoogleFonts.prompt(fontSize: 16)),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // SizedBox(height: 10),
                    // Row(
                    //   children: [
                    //     Text(
                    //       'After Workout',
                    //       style: GoogleFonts.prompt(
                    //           fontSize: 16, fontWeight: FontWeight.bold),
                    //     ),
                    //     SizedBox(width: 22),
                    //     InkWell(
                    //       onTap: () {},
                    //       child: Container(
                    //         height: 25,
                    //         width: 50,
                    //         decoration: BoxDecoration(
                    //           border: Border.all(color: Colors.grey),
                    //           borderRadius: BorderRadius.circular(10),
                    //           color: Color.fromARGB(255, 206, 203, 203),
                    //         ),
                    //         child: Text('time',
                    //             style: GoogleFonts.prompt(fontSize: 16)),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    SizedBox(height: 10),
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
                          child: Text(
                            "CANCEL",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black),
                            onPressed: () {},
                            child: Text(
                              "SAVE",
                              style: TextStyle(color: Colors.white),
                            ))
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          )))),
    );
  }
}
