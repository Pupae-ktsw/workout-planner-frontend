import 'package:frontend/models/user.dart';

abstract class Repository {
  Future<Object> getObject();
  Future<Object> getObjectById(String id);
  Future<List<Object>> getAllObjectById(String id);
  Future<Object> updateObject(Object obj);
  Future<List<Object>> getAllObject();
}
