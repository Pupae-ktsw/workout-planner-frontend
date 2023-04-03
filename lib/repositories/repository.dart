abstract class Repository {
  Future<Object> getObject();
  Future<Object?> updateObject(Object obj);
  Future postObject(Object obj);
}
