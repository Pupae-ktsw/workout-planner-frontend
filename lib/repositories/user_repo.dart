// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/config.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/repositories/repository.dart';
// import 'package:http/http.dart' as http;
import 'package:frontend/services/api_service.dart';
import 'dart:convert';

class UserRepo implements Repository {
  String url = Config.userAPI;
  var http = CustomHttp();

  // GET User
  @override
  Future<Object> getObject() async {
    User user = User();
    // const storage = FlutterSecureStorage();
    // String? token = await storage.read(key: 'accessToken');
    var response = await http.get(Uri.parse(url));
    var body = json.decode(response.body);
    user = User.fromJson(body);
    return user;
  }

  // PUT User
  @override
  Future<Object> updateObject(Object obj) {
    User user = obj as User;

    // TODO: implement updateObject
    throw UnimplementedError();
  }

  @override
  Future<List<Object>> getAllObject() {
    // TODO: implement getAllObject
    throw UnimplementedError();
  }

  @override
  Future<Object> getObjectById(String id) {
    // TODO: implement getObjectById
    throw UnimplementedError();
  }

  @override
  Future<List<Object>> getAllObjectById(String id) {
    // TODO: implement getAllObjectById
    throw UnimplementedError();
  }

  @override
  Future postObject(Object obj) {
    // TODO: implement createObject
    throw UnimplementedError();
  }

  @override
  Future deleteObjectById(String id) {
    // TODO: implement deleteObjectById
    throw UnimplementedError();
  }

  @override
  Future<List<Object>> getAllObjectByKeyword(String keyword) {
    // TODO: implement getAllObjectByKeyword
    throw UnimplementedError();
  }
}
