import 'package:frontend/models/user.dart';
import 'package:frontend/repositories/repository.dart';

class UserController {
  final Repository _repository;

  UserController(this._repository);
  Future<User> getLoginUser() async {
    return await _repository.getObject() as User;
  }
}
