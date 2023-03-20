import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData appTheme() {
  return ThemeData(
    primarySwatch: Colors.red,
    textTheme: const TextTheme(
      // login and register screen
      headline1: TextStyle(
<<<<<<< HEAD:lib/components/formart_text.dart
          fontSize: 62.0, fontWeight: FontWeight.w700, color: Colors.black),

      headline2: TextStyle(fontSize: 16, color: Colors.black),

      headline3: TextStyle(fontSize: 20, color: Colors.black),

=======
          fontSize: 40.0, fontWeight: FontWeight.w700, color: Colors.black),
      // app bar
      // error msg
>>>>>>> feature/profile:lib/components/format_text.dart
      bodyText1: TextStyle(fontSize: 18.0),

      bodyText2: TextStyle(fontSize: 16.0),
    ),
  );
}
