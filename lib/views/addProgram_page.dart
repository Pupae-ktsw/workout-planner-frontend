import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class addProgram extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Add Program",
      home: showAddProgramPage(),
    );
  }
}

class showAddProgramPage extends StatefulWidget {
  @override
  _AddProgramPageState createState() => _AddProgramPageState();
}

class _AddProgramPageState extends State<showAddProgramPage> {
  final _retitionList = ["weekly", "everyday"];
  String _selectedValue = "weekly";
  bool? _isChecked = false;
  DateTime _dateTime = DateTime.now();
  TimeOfDay _time = TimeOfDay(hour: 10, minute: 30);

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
              Container(
                height: 25,
                width: 300,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromARGB(255, 206, 203, 203)),
                child: Text('Progran name',
                    style: GoogleFonts.prompt(fontSize: 16)),
              ),
              SizedBox(height: 20),
              Container(
                height: 150,
                width: 260,
                child: Image.network(
                    'https://static.chloeting.com/videos/61bbdc7e2cb3b78eb6ac2bba/efca6f80-5ed1-11ec-b182-df31ae6aab45.jpeg',
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
                    Text('Color',
                        style: GoogleFonts.prompt(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Row(
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
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text('Before Workout',
                            style: GoogleFonts.prompt(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        SizedBox(width: 10),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            height: 25,
                            width: 50,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                              color: Color.fromARGB(255, 206, 203, 203),
                            ),
                            child: Text('time',
                                style: GoogleFonts.prompt(fontSize: 16)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          'After Workout',
                          style: GoogleFonts.prompt(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 22),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            height: 25,
                            width: 50,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                              color: Color.fromARGB(255, 206, 203, 203),
                            ),
                            child: Text('time',
                                style: GoogleFonts.prompt(fontSize: 16)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.white),
                          onPressed: () {},
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
                  ],
                ),
              ),
            ],
          )))),
    );
  }
}

// _number() {
//   return Wrap(
//     direction: Axis.horizontal,
//     children: [
//       List.generate(5, (index) {
//         return Container();
//       })
//     ],
//   );
// }
