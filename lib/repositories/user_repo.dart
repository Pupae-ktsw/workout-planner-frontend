import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/config.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/repositories/repository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserRepo implements Repository {
  String url = Config.userAPI;

  @override
  Future<Object> getObject() async {
    User user = User();
    const storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'accessToken');
    var response = await http
        .get(Uri.parse(url), headers: {'Authorization': "Bearer $token"});
    var body = json.decode(response.body);
    user = User.fromJson(body);
    return user;
  }
}
