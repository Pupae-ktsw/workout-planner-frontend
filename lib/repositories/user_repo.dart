import 'package:frontend/config.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/repositories/repository.dart';
import 'package:frontend/services/api_service.dart';
import 'dart:convert';

class UserRepo implements Repository {
  String url = Config.userAPI;
  String signUpUrl = Config.signupAPI;
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
  Future<Object?> updateObject(Object obj) async {
    User user = obj as User;
    String jsonReq = json.encode(user);
    var response = await http.put(Uri.parse(url), body: jsonReq);
    var body = await json.decode(response.body);
    if (response.statusCode == 200) {
      User updatedUser = User.fromJson(body);
      return updatedUser;
    }
    return null;
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
  Future postObject(Object obj) async {
    User user = obj as User;
    String jsonReq = json.encode(user);
    print(jsonReq);
    var response = await http.post(Uri.parse(signUpUrl), body: jsonReq);
    print(response.body);
  }
}
