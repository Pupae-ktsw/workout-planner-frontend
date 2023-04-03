import 'package:frontend/models/user.dart';

abstract class Repository {
  Future<Object> getObject();
  Future<Object> getObjectById(String id);
  Future<List<Object>> getAllObjectByKeyword(String keyword);
  Future<Object> updateObject(Object obj);
  Future<List<Object>> getAllObject();
  Future postObject(Object obj);
  Future deleteObjectById(String id);
  Future<List<Object>> getAllObjectById(String id);
}
