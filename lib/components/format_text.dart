import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData appTheme() {
  return ThemeData(
    fontFamily: GoogleFonts.prompt().fontFamily,
    primarySwatch: Colors.red,
    textTheme: const TextTheme(
      // login and register screen
      headline1: TextStyle(
          fontSize: 40.0, fontWeight: FontWeight.w700, color: Colors.black),
      // app bar
      // error msg
      bodyText1: TextStyle(fontSize: 20.0),

      bodyText2: TextStyle(fontSize: 16.0),
    ),
  );
}
