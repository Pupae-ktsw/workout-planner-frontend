import 'package:frontend/models/youtubeVid.dart';

class DayOfProgram {
  String? id;
  String? programId;
  int? numberOfDay;
  String? dateCalendar;
  String? workoutStatus;
  YoutubeVid? youtubeVid;

  DayOfProgram({
    this.id,
    this.programId,
    this.numberOfDay,
    this.dateCalendar,
    this.workoutStatus,
    this.youtubeVid,
  });

  DayOfProgram.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    programId = json['program_id'];
    numberOfDay = json['numberOfDay'];
    dateCalendar = json['dateCalendar'];
    workoutStatus = json['workoutStatus'];
    youtubeVid = json['youtubeVid'] != null
        ? new YoutubeVid.fromJson(json['youtubeVid'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['program_id'] = this.programId;
    data['numberOfDay'] = this.numberOfDay;
    data['dateCalendar'] = this.dateCalendar;
    data['workoutStatus'] = this.workoutStatus;
    if (this.youtubeVid != null) {
      data['youtubeVid'] = this.youtubeVid!.toJson();
    }

    return data;
  }
}
