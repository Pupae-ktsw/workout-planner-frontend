import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  List testData = [
    {'name': 'Program 1'},
    {'name': 'Program 2'}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Column(
          children: [
            SizedBox(
              height: 20,
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
            Expanded(
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  buildCard(),
                  SizedBox(width: 20),
                  buildCard(),
                  SizedBox(width: 20),
                  buildCard()
                ],
              ),
            )
          ],
          // ),
        ),
      ),
    ));
  }

  Widget buildCard() => Container(
        width: 150,
        height: 40,
        color: Colors.red,
      );
}
