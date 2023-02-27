import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProgramPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Program Page'),
      ),
      body: Container(
        child: Align(
          alignment: Alignment.topLeft,
          child: Text(
            'ADD PROGRAM',
            style: GoogleFonts.prompt(
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }
}
