import 'dart:convert';

import 'package:frontend/models/dayOfProgram.dart';
import 'package:frontend/models/program.dart';

class CalendarEvent {
  String? id;
  DateTime? eventDate;
  String? userId;
  List<DayOfProgram> dayProgram = [];

  CalendarEvent(
      {this.id, this.eventDate, this.userId, required this.dayProgram});

  CalendarEvent.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    eventDate = DateTime.parse(json['eventDate']);
    userId = json['user_id'];

    // List<dynamic> programList = json['programs'];
    // for (var pg in programList) {
    //   programs.add(Program.fromJson(jsonDecode(jsonEncode(pg))));
    // }

    List<dynamic> dayProgramList = json['dayProgram'];
    for (var dayPg in dayProgramList) {
      dayProgram.add(DayOfProgram.fromJson(jsonDecode(jsonEncode(dayPg))));
    }
  }

  // Map<String, dynamic> toJson() {
  //   Map<String, dynamic> _data = new Map<String, dynamic>();
  //   // _data['_id'] = id;
  //   _data['eventDate'] = eventDate;
  //   _data['user_id'] = userId;
  //   return _data;
  // }
}
