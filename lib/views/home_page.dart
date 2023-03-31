import 'package:flutter/material.dart';
import 'package:frontend/controllers/day_of_program_controller.dart';
import 'package:frontend/controllers/program_controller.dart';
import 'package:frontend/models/program.dart';
import 'package:frontend/repositories/day_of_program_repo.dart';
import 'package:google_fonts/google_fonts.dart';

import '../repositories/program_repo.dart';

class HomePage extends StatelessWidget {
  List testData = [
    {'name': 'Program 1', 'Type': 'Abs'},
    {'name': 'Program 2', 'Type': 'Workout'},
    {'name': 'Program 3', 'Type': 'Workout'},
    {'name': 'Program 4', 'Type': 'Workout'},
    {'name': 'Program 5', 'Type': 'Workout'}
  ];
  DayOfProgramController dayOfProgramController =
      DayOfProgramController(DayOfProgramRepo());
  ProgramController programController = ProgramController(ProgramRepo());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'WORKOUT PLANNER',
                  style: GoogleFonts.prompt(
                    fontSize: 32,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Align(
                alignment: Alignment.topLeft,
                child: Text('Today\'s Programs',
                    style: GoogleFonts.prompt(
                      textStyle: Theme.of(context).textTheme.bodyText1,
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 145,
                child: FutureBuilder(
                  // future: ,
                  builder: (context, snapshot) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: InkWell(
                        onTap: () {
                          debugPrint('tapped');
                        },
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: Colors.black,
                            ),
                            child: SizedBox(
                              width: 200,
                            )),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.topLeft,
                child: Text('Weight Training Programs',
                    style: GoogleFonts.prompt(
                      textStyle: Theme.of(context).textTheme.bodyText1,
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 150,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: testData.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        debugPrint('tapped');
                      },
                      child: Container(
                        width: 300,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: ListTile(
                            title: Text(testData[index]['name']),
                            subtitle: Text(testData[index]['Type']),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.topLeft,
                child: Text('Body Weight Programs',
                    style: GoogleFonts.prompt(
                      textStyle: Theme.of(context).textTheme.bodyText1,
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 150,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: testData.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        debugPrint('tapped');
                      },
                      child: Container(
                        width: 300,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: ListTile(
                            title: Text(testData[index]['name']),
                            subtitle: Text(testData[index]['Type']),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.topLeft,
                child: Text('Cardio Programs',
                    style: GoogleFonts.prompt(
                      textStyle: Theme.of(context).textTheme.bodyText1,
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 150,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: testData.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        debugPrint('tapped');
                      },
                      child: Container(
                        width: 300,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: ListTile(
                            title: Text(testData[index]['name']),
                            subtitle: Text(testData[index]['Type']),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
            // ),
          ),
        ),
      ),
    ));
  }

  Widget buildCard() => Container(
        padding: EdgeInsets.all(100),
        decoration: BoxDecoration(
            color: Colors.red, borderRadius: BorderRadius.circular(12)),
      );
}
