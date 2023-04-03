import 'package:frontend/config.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/repositories/repository.dart';
import 'package:frontend/services/api_service.dart';
import 'dart:convert';

class UserRepo implements Repository {
  String url = Config.userAPI;
  var http = CustomHttp();

  // GET User
  @override
  Future<Object> getObject() async {
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var body = json.decode(response.body);
        User user = User.fromJson(body);
        return user;
      }
    } catch (err) {
      print(err);
    }
    return Null;
  }

  // PUT User
  @override
  Future<Object> updateObject(Object obj) async {
    User user = obj as User;
    User updatedUser = User();
    String jsonReq = json.encode(user);
    var response = await http.put(Uri.parse(url), body: jsonReq);
    if (response.statusCode == 200) {
      var body = await json.decode(response.body);
      updatedUser = User.fromJson(body);
    }
    return updatedUser;
  }

  Future<Object?> updateObjectByJson(String jsonText) async {
    var response =
        await http.put(Uri.parse('$url/changePassword'), body: jsonText);
    if (response.statusCode == 200) {
      return response.body;
    } else if (response.statusCode == 400) {
      var body = json.decode(response.body);
      print('res body msg: ${body['message']}');
      return body['message'];
    }
    return null;
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
