import 'package:flutter/material.dart';
import 'package:frontend/controllers/day_of_program_controller.dart';
import 'package:frontend/controllers/program_controller.dart';
import 'package:frontend/models/youtubeVid.dart';
import 'package:frontend/repositories/day_of_program_repo.dart';
import 'package:frontend/repositories/program_repo.dart';

import '../models/dayOfProgram.dart';
import '../models/program.dart';

class ProgramProvider with ChangeNotifier {
  String? id;
  String? programName = "Program Name";
  String? programStatus;
  List<StartEndDate> startEndDate = [];
  String? color;
  String? workoutTime = "10:30";
  bool? isReminder = false;
  String? repeatType = "Weekly";
  int? repeatDaily = 1;
  List<int>? repeatWeekly = [];
  String? thumbnail;
  int? remindAf = 30;
  int? remindBf = 0;
  List<DayOfProgram> dayofProgramList = [];
  // List<DayOfProgram> dayofProgramSuggestList = [];
  int numberOfDay = 1;
  int shuffleIndex = 0;

  DayOfProgramController dayOfProgramController =
      DayOfProgramController(DayOfProgramRepo());

  setProgramId(String prograamId) {
    id = prograamId;
    notifyListeners();
  }

  setshuffleIndex(int index) {
    this.shuffleIndex = index;
    notifyListeners();
  }

  setNumberOfDay(int numberOfDay) {
    this.numberOfDay = numberOfDay;
    notifyListeners();
  }

  setThumbnail(String thumbnail) {
    this.thumbnail = thumbnail;
    notifyListeners();
  }

  setShuffleDay(int shuffleDay) {
    this.shuffleIndex = shuffleDay;
    notifyListeners();
  }

  setRepeatDaily(dynamic repeatDaily) {
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

  setDayOfProgramList(List<DayOfProgram> dayOfProgramListInput) {
    dayofProgramList = dayOfProgramListInput;
    if (thumbnail == null && dayofProgramList.isNotEmpty) {
      thumbnail = dayofProgramList[0].youtubeVid!.thumbnail;
    }
    notifyListeners();
  }

  void addDayOfProgram(YoutubeVid youtubeVid) {
    if (dayofProgramList.isEmpty) this.thumbnail = youtubeVid.thumbnail;
    DayOfProgram dayOfProgram =
        DayOfProgram(numberOfDay: numberOfDay, youtubeVid: youtubeVid);
    numberOfDay = numberOfDay + 1;
    dayofProgramList.add(dayOfProgram);

    notifyListeners();
  }

  void shuffleDayOfProgram(YoutubeVid youtubeVid) {
    dayofProgramList[shuffleIndex].youtubeVid = youtubeVid;
    if (shuffleIndex == 0) {
      thumbnail = dayofProgramList[shuffleIndex].youtubeVid!.thumbnail;
    }
    notifyListeners();
  }

  void removeDayOfProgram(int index) {
    int newNumberOfDay = 1;
    dayofProgramList.removeAt(index);
    // print(dayofProgramList.toList());
    if (dayofProgramList.isEmpty) {
      numberOfDay = 1;
    } else if (dayofProgramList.isNotEmpty) {
      for (var i = 0; i < dayofProgramList.length; i++) {
        dayofProgramList[i].numberOfDay = newNumberOfDay;
        newNumberOfDay = newNumberOfDay + 1;
      }
      numberOfDay = newNumberOfDay;
    }
    dayofProgramList.forEach((element) {
      print(element.numberOfDay);
    });
    notifyListeners();
  }
}
