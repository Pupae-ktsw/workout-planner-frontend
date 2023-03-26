import 'package:frontend/models/user.dart';

abstract class Repository {
  Future<Object> getObject();
  Future<Object> updateObject(Object obj);
  Future<List<Object>> getAllObject();
}
