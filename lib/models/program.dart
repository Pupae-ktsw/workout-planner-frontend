import 'dart:convert';

Program programFromJson(String str) => Program.fromJson(json.decode(str));

String programToJson(Program data) => json.encode(data.toJson());

class Program {
  Program({
    this.id,
    this.programName,
    this.programStatus,
    required this.startEndDate,
    this.color,
    this.workoutTime,
    this.isReminder,
    this.repeatType,
    this.repeatDaily,
    this.repeatWeekly,
    this.totalDays,
    this.thumbnail,
    this.latestDay,
    this.userId,
  });

  String? id;
  String? programName;
  String? programStatus;
  List<StartEndDate> startEndDate;
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

  factory Program.fromJson(Map<String, dynamic> json) => Program(
        id: json["_id"],
        programName: json["programName"],
        programStatus: json["programStatus"],
        startEndDate: List<StartEndDate>.from(
            json["startEndDate"].map((x) => StartEndDate.fromJson(x))),
        color: json["color"],
        workoutTime: json["workoutTime"],
        isReminder: json["isReminder"],
        repeatType: json["repeatType"],
        repeatDaily: json["repeatDaily"],
        repeatWeekly: json["repeatWeekly"],
        totalDays: json["totalDays"],
        thumbnail: json["thumbnail"],
        latestDay: json["latestDay"],
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "programName": programName,
        "programStatus": programStatus,
        "startEndDate": List<dynamic>.from(startEndDate.map((x) => x.toJson())),
        "color": color,
        "workoutTime": workoutTime,
        "isReminder": isReminder,
        "repeatType": repeatType,
        "repeatDaily": repeatDaily,
        "repeatWeekly": repeatWeekly,
        "totalDays": totalDays,
        "thumbnail": thumbnail,
        "latestDay": latestDay,
        "user_id": userId,
      };
}

class StartEndDate {
  StartEndDate({
    required this.startDate,
    required this.id,
  });

  DateTime startDate;
  String id;

  factory StartEndDate.fromJson(Map<String, dynamic> json) => StartEndDate(
        startDate: DateTime.parse(json["startDate"]),
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "startDate": startDate.toIso8601String(),
        "_id": id,
      };
}
