import 'dart:convert';

import 'package:frontend/models/program.dart';
import 'package:frontend/repositories/repository.dart';

import '../config.dart';
import '../services/api_service.dart';

class ProgramRepo implements Repository {
  String url = Config.programAPI;
  String urlSuggest = Config.programSuggestAPI;
  var http = CustomHttp();

  @override
  Future<List<Object>> getSuggestPrograms() async {
    List<Program> programList = [];

    var response = await http.get(Uri.parse(urlSuggest));
    var body = json.decode(response.body);
    print(body);
    for (var i = 0; i < body.length; i++) {
      programList.add(Program.fromJson(body[i]));
      // print(body[i].programName);
    }
    return programList;
  }

  @override
  Future<Object> getObject() {
    // TODO: implement getObject
    throw UnimplementedError();
  }

  @override
  Future<List<Object>> getAllObject() async {
    List<Program> programList = [];

    var response = await http.get(Uri.parse(url));
    var body = json.decode(response.body);
    for (var i = 0; i < body.length; i++) {
      programList.add(Program.fromJson(body[i]));
    }
    return programList;
  }

  @override
  Future<Object> updateObject(Object obj) {
    // TODO: implement updateObject
    throw UnimplementedError();
  }

  @override
  Future<Object> getObjectById(String id) async {
    Program program = Program();
    String getByIdUrl = url + "/" + id;

    var response = await http.get(Uri.parse(getByIdUrl));
    var body = json.decode(response.body);
    program = Program.fromJson(body);

    return program;
  }

  @override
  Future postObject(Object obj) async {
    Program program = Program();
    program = obj as Program;

    var response =
        await http.post(Uri.parse(url), body: jsonEncode(program.toJson()));
  }

  @override
  Future<List<Object>> getAllObjectById(String id) {
    // TODO: implement getAllObjectById
    throw UnimplementedError();
  }
}
