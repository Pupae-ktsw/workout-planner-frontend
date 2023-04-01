import 'package:flutter/material.dart';
import 'package:frontend/models/youtubeVid.dart';

import '../models/dayOfProgram.dart';
import '../models/program.dart';

class ProgramProvider with ChangeNotifier {
  List<DayOfProgram> _dayOfProgramList = [];
  String? id;
  String? programName;
  String? programStatus;
  List<StartEndDate>? startEndDate;
  String? color;
  String? workoutTime;
  bool? isReminder;
  String? repeatType;
  int? repeatDaily;
  List<int>? repeatWeekly;
  int? totalDays;
  String? thumbnail;
  int? latestDay;
  String? userId;
  int? remindAf;
  int? remindBf;
  List<DayOfProgram>? dayofProgram;

  setRepeatDaily(int repeatDaily) {
    this.repeatDaily = repeatDaily;
    notifyListeners();
  }

  setRepeatWeekly(List<int> repeatWeekly) {
    this.repeatWeekly = repeatWeekly;
    notifyListeners();
  }

  setProgramName(String programName) {
    this.programName = programName;
    notifyListeners();
  }

  setColor(String color) {
    this.color = color;
    notifyListeners();
  }

  setWorkoutTime(String workoutTime) {
    this.workoutTime = workoutTime;
    notifyListeners();
  }

  setStartEndDate(List<StartEndDate> startEndDate) {
    this.startEndDate = startEndDate;
    notifyListeners();
  }

  setIsReminder(bool isReminder) {
    this.isReminder = isReminder;
    notifyListeners();
  }

  setRemindAf(int? remindAf) {
    this.remindAf = remindAf;
    notifyListeners();
  }

  setRemindBf(int? remindBf) {
    this.remindBf = remindBf;
    notifyListeners();
  }

  setRepeatType(String repeatType) {
    this.repeatType = repeatType;
    notifyListeners();
  }

  void addDayOfProgram(DayOfProgram dayOfProgram) {
    _dayOfProgramList.add(dayOfProgram);
    notifyListeners();
  }
}
