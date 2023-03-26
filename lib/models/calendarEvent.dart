class CalendarEvent {
  String? id;
  DateTime? eventDate;
  String? userId;
  late List<String> programs;

  CalendarEvent({this.id, this.eventDate, this.userId, required this.programs});

  CalendarEvent.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    eventDate = json['eventDate'];
    userId = json['user_id'];
    programs = json['programs'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> _data = new Map<String, dynamic>();
    _data['_id'] = id;
    _data['eventDate'] = eventDate;
    _data['user_id'] = userId;
    _data['programs'] = programs;
    return _data;
  }
}
