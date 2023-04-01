import 'package:frontend/models/dayOfProgram.dart';

class Program {
  Program(
      {
      // this.id,
      this.programName,
      // this.programStatus,
      this.startEndDate,
      this.color,
      this.workoutTime,
      this.isReminder,
      this.repeatType,
      this.repeatDaily,
      this.repeatWeekly,
      this.remindAf,
      this.remindBf,
      this.totalDays,
      // this.thumbnail,
      // this.latestDay,
      // this.userId,
      this.dayofProgram});

  String? id;
  String? programName;
  String? programStatus;
  List<StartEndDate>? startEndDate;
  String? color;
  String? workoutTime;
  bool? isReminder;
  String? repeatType;
  int? repeatDaily;
  dynamic repeatWeekly;
  int? totalDays;
  String? thumbnail;
  int? latestDay;
  String? userId;
  int? remindAf;
  int? remindBf;
  List<DayOfProgram>? dayofProgram;

  Program.fromJson(Map<String, dynamic> json) {
    // return Program(
    id = json["_id"];
    programName = json["programName"];
    programStatus = json["programStatus"];

    if (json['startEndDate'] != null) {
      List startEndDateList = json['startEndDate'].toList();

      startEndDate =
          startEndDateList.map((e) => StartEndDate.fromJson(e)).toList();
    }

    color = json["color"];
    workoutTime = json["workoutTime"];
    isReminder = json["isReminder"];
    repeatType = json["repeatType"];
    repeatDaily = json["repeatDaily"];
    repeatWeekly = json["repeatWeekly"];
    totalDays = json["totalDays"];
    thumbnail = json["thumbnail"];
    latestDay = json["latestDay"];
    userId = json["user_id"];
    remindAf = json["remindAf"];
    remindBf = json["remindBf"];
  }

  Map<String, dynamic> toJson() => {
        // "_id": id,
        "programName": programName ?? '',
        // "programStatus": programStatus,
        "startEndDate":
            List<dynamic>.from(startEndDate!.map((x) => x.toJson())),
        "color": color ?? '',
        "workoutTime": workoutTime ?? '',
        "isReminder": isReminder ?? false,
        "repeatType": repeatType ?? '',
        "repeatDaily": repeatDaily ?? '',
        "repeatWeekly": repeatWeekly ?? '',
        "remindAf": remindAf ?? '',
        "remindBf": remindBf ?? '',
        "totalDays": totalDays ?? '',
        "dayOfProgram":
            List<dynamic>.from(dayofProgram!.map((x) => x.toJson())),
        // "thumbnail": thumbnail,
        // "latestDay": latestDay,
        // "user_id": userId,
      };
}

class StartEndDate {
  StartEndDate({
    this.startDate,
    this.id,
    this.endDate,
  });

  DateTime? startDate, endDate;
  String? id;

  factory StartEndDate.fromJson(Map<String, dynamic> json) => StartEndDate(
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "startDate": startDate.toString(),
        "endDate": endDate.toString(),
        // "_id": id,
      };
}
