import 'dart:math';

class DayOfProgram {
  String? sId;
  String? programId;
  int? numberOfDay;
  int? totalDuration;
  String? dateCalendar;
  List<Workouts>? workouts;

  DayOfProgram({
    this.sId,
    this.programId,
    this.numberOfDay,
    this.totalDuration,
    this.dateCalendar,
    this.workouts,
  });

  DayOfProgram.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    programId = json['program_id'];
    numberOfDay = json['numberOfDay'];
    totalDuration = json['totalDuration'];
    dateCalendar = json['dateCalendar'];

    if (json['workouts'] != null) {
      List<dynamic> workoutList = json['workouts'];
      workouts = workoutList.map((e) => Workouts.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = sId;
    data['program_id'] = programId;
    data['numberOfDay'] = numberOfDay;
    data['totalDuration'] = totalDuration;
    data['dateCalendar'] = dateCalendar;
    if (workouts != null) {
      data['workouts'] = workouts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Workouts {
  YoutubeVid? youtubeVid;
  String? workoutStatus;
  String? sId;

  Workouts({this.youtubeVid, this.workoutStatus, this.sId});

  Workouts.fromJson(Map<String, dynamic> json) {
    youtubeVid = json['youtubeVid'] != null
        ? new YoutubeVid.fromJson(json['youtubeVid'])
        : null;
    workoutStatus = json['workoutStatus'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (youtubeVid != null) {
      data['youtubeVid'] = youtubeVid!.toJson();
    }
    data['workoutStatus'] = workoutStatus;
    data['_id'] = sId;
    return data;
  }
}

class YoutubeVid {
  String? thumbnail;
  String? title;
  String? channel;
  int? duration;

  YoutubeVid({this.thumbnail, this.title, this.channel, this.duration});

  YoutubeVid.fromJson(Map<String, dynamic> json) {
    thumbnail = json['thumbnail'];
    title = json['title'];
    channel = json['channel'];
    duration = json['duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['thumbnail'] = thumbnail;
    data['title'] = title;
    data['channel'] = channel;
    data['duration'] = duration;
    return data;
  }
}
