import 'package:flutter/material.dart';
import 'package:frontend/models/youtubeVid.dart';

import '../models/dayOfProgram.dart';
import '../models/program.dart';

class ProgramProvider with ChangeNotifier {
  List<DayOfProgram> _dayOfProgramList = [];
  String? id;
  String? programName = "Program Name";
  String? programStatus;
  List<StartEndDate>? startEndDate;
  String? color;
  String? workoutTime;
  bool? isReminder = false;
  String? repeatType = "Weekly";
  int? repeatDaily = 1;
  List<int>? repeatWeekly = [];
  String? thumbnail;
  int? remindAf = 0;
  int? remindBf = 0;
  List<DayOfProgram> dayofProgramList = [];
  int? numberOfDay = 1;
  int shuffleIndex = 0;

  setShuffleDay(int shuffleDay) {
    this.shuffleIndex = shuffleDay;
    notifyListeners();
  }

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

  void addDayOfProgram(YoutubeVid youtubeVid) {
    DayOfProgram dayOfProgram =
        DayOfProgram(numberOfDay: numberOfDay, youtubeVid: youtubeVid);
    numberOfDay = numberOfDay! + 1;
    dayofProgramList.add(dayOfProgram);

    notifyListeners();
  }

  void shuffleDayOfProgram(YoutubeVid youtubeVid) {
    dayofProgramList[shuffleIndex].youtubeVid = youtubeVid;
    notifyListeners();
  }
}
