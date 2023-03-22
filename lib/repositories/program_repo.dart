import 'dart:convert';

import 'package:frontend/models/program.dart';
import 'package:frontend/repositories/repository.dart';

import '../config.dart';
import '../services/api_service.dart';

class ProgramRepo implements Repository {
  String url = Config.programAPI;
  var http = CustomHttp();

  @override
  Future<Object> getObject() async {
    Program program = Program();

    var response = await http.get(Uri.parse(url));
    var body = json.decode(response.body);
    program = Program.fromJson(body);
    return program;
  }

  @override
  Future<List<Object>> getAllObject() async {
    List<Program> programList = [];

    var response = await http.get(Uri.parse(url));
    // print('status code: ${response.statusCode}');
    var body = json.decode(response.body);
    for (var i = 0; i < body.length; i++) {
      programList.add(Program.fromJson(body[i]));
      // print('program: ${programList[i].programName}');
    }
    return programList;
  }

  @override
  Future<Object> updateObject(Object obj) {
    // TODO: implement updateObject
    throw UnimplementedError();
  }
}
