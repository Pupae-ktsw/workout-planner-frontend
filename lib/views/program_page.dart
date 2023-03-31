import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/controllers/program_controller.dart';
import 'package:frontend/models/program.dart';
import 'package:frontend/repositories/program_repo.dart';
import 'package:frontend/views/addProgram_page.dart';
import 'package:frontend/views/dayOfProgram_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

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
  const showProgramPage({Key? key}) : super(key: key);
  @override
  _ProgramPageState createState() => _ProgramPageState();
}

class _ProgramPageState extends State<showProgramPage> {
  final _programTypeList = ["All", "Challenging", "Completed"];
  String _selectedValue = "All";
  var _programController = ProgramController(ProgramRepo());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 16, top: 25, right: 16),
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
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return showAddProgramPage();
                            }));
                          },
                          child: Text(
                            'Add Program',
                            style: TextStyle(color: Colors.white),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: SizedBox(
                      width: 120,
                      child: DropdownButtonFormField(
                        value: _selectedValue,
                        items: _programTypeList
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
                ],
              ),
              Expanded(
                child: FutureBuilder<List<Object>>(
                    future: _programController.getAllProgram(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Center(child: Text("Error"));
                      }
                      if (_selectedValue == 'Completed') {
                        snapshot.data?.removeWhere((element) =>
                            (element as Program).programStatus ==
                            'Challenging');
                      }
                      if (_selectedValue == 'Challenging') {
                        snapshot.data?.removeWhere((element) =>
                            (element as Program).programStatus == 'Completed');
                      }

                      return snapshot.hasData
                          ? ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: snapshot.data?.length ?? 0,
                              itemBuilder: ((context, index) {
                                var program = snapshot.data?[index] as Program;
                                // _programController.getProgramById(program.id!);
                                DateTime? startDate;

                                for (var i in program.startEndDate!) {
                                  startDate = i.startDate;
                                }

                                String? formattedStartDate =
                                    DateFormat('dd/MM/yyyy').format(startDate!);

                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DayOfProgramPage(
                                                    program: program)));
                                  },
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.network(program
                                                  .thumbnail ??
                                              "https://www.shape.com/thmb/DjCIHGX6cWaIniuqHeBAAreNE08=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/best-cardio-exercises-promo-2000-498cbfb8f07541b78572bf810e7fb600.jpg"),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                program.programName ??
                                                    "No program",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                formattedStartDate == null
                                                    ? "No date"
                                                    : "start date : $formattedStartDate",
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }))
                          : Center(
                              child: Text('No program'),
                            );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
