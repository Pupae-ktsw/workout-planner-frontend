import 'dart:convert';

Program programFromJson(String str) => Program.fromJson(json.decode(str));

// String programToJson(Program data) => json.encode(data.toJson());

class Program {
  Program({
    this.id,
    this.programName,
    this.programStatus,
    this.startEndDate,
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
  List<StartEndDate>? startEndDate;
  // List<StartEndDate>? startEndDateList;
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

  Program.fromJson(Map<String, dynamic> json) {
    // return Program(
    id = json["_id"];
    programName = json["programName"];
    programStatus = json["programStatus"];

    if (json['startEndDate'] != null) {
      List startEndDateList =
          json['startEndDate'].entries.map((e) => e.value).toList();

      startEndDate = startEndDateList
          .map((e) => StartEndDate.fromJson(e))
          .toList()
          .cast<StartEndDate>();
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
    // );
    // id = json["_id"];
    // programName = json["programName"];
    // programStatus = json["programStatus"];
    // // startEndDate = List<StartEndDate>.from(
    // //     json["startEndDate"].map((x) => StartEndDate.fromJson(x)).toList());
    // if (json['startEndDate'] != null) {
    //   // startEndDate = <StartEndDate>[];
    //   // json['startEndDate'].isNotEmpty
    //   //     ? json['startEndDate'].forEach((v) {
    //   //         startEndDate!.add(StartEndDate.fromJson(v));
    //   //       })
    //   //     : null;
    //   json['startEndDate'].forEach((v) {
    //     startEndDate!.add(StartEndDate.fromJson(v));
    //   });
    // }
    // color = json["color"];
    // workoutTime = json["workoutTime"];
    // isReminder = json["isReminder"];
    // repeatType = json["repeatType"];
    // repeatDaily = json["repeatDaily"];
    // repeatWeekly = json["repeatWeekly"];
    // totalDays = json["totalDays"];
    // thumbnail = json["thumbnail"];
    // latestDay = json["latestDay"];
    // userId = json["user_id"];
    // // );
  }

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "programName": programName,
//         "programStatus": programStatus,
//         "startEndDate": List<dynamic>.from(startEndDate.map((x) => x.toJson())),
//         "color": color,
//         "workoutTime": workoutTime,
//         "isReminder": isReminder,
//         "repeatType": repeatType,
//         "repeatDaily": repeatDaily,
//         "repeatWeekly": repeatWeekly,
//         "totalDays": totalDays,
//         "thumbnail": thumbnail,
//         "latestDay": latestDay,
//         "user_id": userId,
//       };
}

// class StartEndDateMap {
//   StartEndDateMap({
//     this.startEndDateMap,
//   });

//   String? startEndDateMap;
// }

class StartEndDate {
  StartEndDate({
    this.startDate,
    this.id,
  });

  DateTime? startDate;
  String? id;

  factory StartEndDate.fromJson(Map<String, dynamic> json) => StartEndDate(
        startDate: DateTime.parse(json["startDate"]),
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "startDate": startDate.toString(),
        "_id": id,
      };
}
