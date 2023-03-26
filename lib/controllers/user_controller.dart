import 'dart:convert';

import 'package:frontend/models/user.dart';
import 'package:frontend/repositories/repository.dart';
import 'package:frontend/repositories/user_repo.dart';

import '../main.dart';

class UserController {
  final Repository _repository;

  UserController(this._repository);
  Future<User> getLoginUser() async {
    User user = await _repository.getObject() as User;
    return user;
  }

  Future<User?> updateUser(Object obj) async {
    User user = obj as User;
    User? updatedUser = await _repository.updateObject(user) as User;
    if (updatedUser.email != null) {
      MyApp.storage.write(key: 'user', value: json.encode(updatedUser));
    } else {
      updatedUser = null;
    }
    return updatedUser;
  }

  Future<String?> updatePassword(String oldPw, String newPw) async {
    String jsonText = '{ "oldPassword":"$oldPw", "newPassword":"$newPw" }';
    String? message = await UserRepo().updateObjectByJson(jsonText) as String?;
    return message;
  }
}
