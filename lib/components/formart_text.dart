import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData appTheme() {
  return ThemeData(
    primarySwatch: Colors.red,
    textTheme: const TextTheme(
      // login and register screen
      headline1: TextStyle(
          fontSize: 62.0, fontWeight: FontWeight.w700, color: Colors.black),

      headline2: TextStyle(fontSize: 16, color: Colors.black),

      headline3: TextStyle(fontSize: 20, color: Colors.black),

      bodyText1: TextStyle(fontSize: 18.0),

      bodyText2: TextStyle(fontSize: 16.0),
    ),
  );
}
