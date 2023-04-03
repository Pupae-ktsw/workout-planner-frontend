import 'dart:convert';

import 'package:frontend/models/calendarEvent.dart';
import 'package:frontend/repositories/repository.dart';

import '../config.dart';
import '../services/api_service.dart';

class CalendarEventRepo implements Repository {
  String url = Config.eventAPI;
  var http = CustomHttp();

  // Get All Events
  @override
  Future<List<Object>> getAllObject() async {
    List<CalendarEvent> eventList = [];
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      for (var i = 0; i < body.length; i++) {
        eventList.add(CalendarEvent.fromJson(body[i]));
      }
    }
    return eventList;
  }

  @override
  Future<Object> getObject() {
    // TODO: implement getObject
    throw UnimplementedError();
  }

  @override
  Future<Object> updateObject(Object obj) {
    // TODO: implement updateObject
    throw UnimplementedError();
  }

  @override
  Future<List<Object>> getAllObjectById(String id) {
    // TODO: implement getAllObjectById
    throw UnimplementedError();
  }

  @override
  Future<Object> getObjectById(String id) {
    // TODO: implement getObjectById
    throw UnimplementedError();
  }

  @override
  Future postObject(Object obj) {
    // TODO: implement postObject
    throw UnimplementedError();
  }
}
