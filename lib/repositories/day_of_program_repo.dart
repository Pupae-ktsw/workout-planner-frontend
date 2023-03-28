import 'dart:convert';

import 'package:frontend/models/dayOfProgram.dart';
import 'package:frontend/models/program.dart';
import 'package:frontend/repositories/repository.dart';
import 'package:frontend/views/dayOfProgram_page.dart';

import '../config.dart';
import '../services/api_service.dart';

class DayOfProgramRepo implements Repository {
  String url = Config.programAPI;
  var http = CustomHttp();

  @override
  Future<List<Object>> getAllObject() {
    // TODO: implement getAllObject
    throw UnimplementedError();
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
  Future<List<Object>> getAllObjectById(String objId) async {
    DayOfProgram dayOfprogram = DayOfProgram();
    String getByIdUrl = url + "/" + objId + "/days";
    List<DayOfProgram> dayOfProgramList = [];

    var response = await http.get(Uri.parse(getByIdUrl));
    var body = json.decode(response.body);
    for (var i = 0; i < body.length; i++) {
      dayOfProgramList.add(DayOfProgram.fromJson(body[i]));
    }

    return dayOfProgramList;
  }

  @override
  Future<Object> getObjectById(String id) {
    // TODO: implement getObjectById
    throw UnimplementedError();
  }

  @override
  Future postObject(Object obj) {
    // TODO: implement createObject
    throw UnimplementedError();
  }
}
