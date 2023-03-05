import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProgramPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Program",
      home: showProgramPage(),
    );
  }
}

class showProgramPage extends StatefulWidget {
  @override
  _ProgramPageState createState() => _ProgramPageState();
}

class _ProgramPageState extends State<showProgramPage> {
  final _programList = ["All", "On going", "Finished"];
  String _selectedValue = "All";

  final List _testData = [
    {
      "name": "Program1",
      "startDate": "1/3/2022",
      "endDate": "14/3/2022",
      "numberOfDay": "50/50",
      "status": "onGoing",
      "imgPath": "lib/images/cardio.jpg"
    },
    {
      "name": "Program2",
      "startDate": "1/3/2022",
      "endDate": "14/3/2022",
      "numberOfDay": "40/50",
      "status": "finished",
      "imgPath": "lib/images/cardio.jpg"
    },
    {
      "name": "Program3",
      "startDate": "1/3/2022",
      "endDate": "14/3/2022",
      "numberOfDay": "20/20",
      "status": "finished",
      "imgPath": "lib/images/cardio.jpg"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Programs',
                        style: GoogleFonts.prompt(
                          fontSize: 32,
                        ),
                      ),
                      ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.red),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.red),
                            )),
                          ),
                          onPressed: () {},
                          child: Text(
                            'Add Program',
                            style: TextStyle(color: Colors.white),
                          ))
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: SizedBox(
                      width: 100,
                      child: DropdownButtonFormField(
                        value: _selectedValue,
                        items: _programList
                            .map((e) => DropdownMenuItem(
                                  child: Text(e),
                                  value: e,
                                ))
                            .toList(),
                        onChanged: (val) {
                          setState(() {
                            _selectedValue = val as String;
                          });
                        },
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: _testData.length,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 150,
                          child: InkWell(
                            onTap: () {
                              debugPrint('tapped');
                            },
                            child: Card(
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: ListTile(
                                dense: true,
                                // leading: _testData[index]['imgPath'] != null
                                //     ? Container(
                                //         decoration: BoxDecoration(
                                //             borderRadius: BorderRadius.circular(10),
                                //             image: DecorationImage(
                                //                 image: FileImage(File(
                                //                     _testData[index]['imgPath'])),
                                //                 fit: BoxFit.cover)),
                                //         width: 100,
                                //         height: 100,
                                //         child: null)
                                //     : Container(
                                //         width: 100,
                                //         height: 100,
                                //         decoration: BoxDecoration(
                                //             borderRadius: BorderRadius.circular(10),
                                //             image: DecorationImage(
                                //                 image: FileImage(File(
                                //                     _testData[index]['imgPath'])),
                                //                 fit: BoxFit.cover)),
                                //       ),
                                title: Text(_testData[index]['name']),
                                subtitle: Text(_testData[index]['startDate'] +
                                    "-" +
                                    _testData[index]['endDate']),
                                trailing: Text(
                                    "Day : " + _testData[index]['numberOfDay']),
                              ),
                            ),
                          ),
                        );
                      }),
                ],
              ),
            ],
          ),
        )),
      ),
    );
  }
}
