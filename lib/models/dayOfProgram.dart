import 'package:frontend/models/program.dart';
import 'package:frontend/models/youtubeVid.dart';

class DayOfProgram {
  String? id;
  String? programId;
  int? numberOfDay;
  String? dateCalendar;
  String? workoutStatus;
  YoutubeVid? youtubeVid;
  Program? program;

  DayOfProgram({
    this.id,
    this.programId,
    this.numberOfDay,
    this.dateCalendar,
    this.workoutStatus,
    this.youtubeVid,
    this.program,
  });

  DayOfProgram.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    programId = json['program_id'];
    numberOfDay = json['numberOfDay'];
    dateCalendar = json['dateCalendar'];
    workoutStatus = json['workoutStatus'];
    youtubeVid = json['youtubeVid'] != null
        ? YoutubeVid.fromJson(json['youtubeVid'])
        : null;
    program =
        json['program_id'] != null ? Program.fromJson(json['program']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = id;
    data['numberOfDay'] = numberOfDay;
    data['dateCalendar'] = dateCalendar;
    data['workoutStatus'] = workoutStatus;
    if (youtubeVid != null) {
      data['youtubeVid'] = youtubeVid!.toJson();
    }

    return data;
  }
}
