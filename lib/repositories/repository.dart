abstract class Repository {
  Future<Object> getObject();
  Future<Object> updateObject(Object obj);
}
