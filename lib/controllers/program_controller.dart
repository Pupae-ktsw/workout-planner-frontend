import '../repositories/repository.dart';

class ProgramController {
  final Repository _repository;

  ProgramController(this._repository);

  Future<Object> getProgram() async {
    return await _repository.getObject();
  }

  Future<List<Object>> getAllProgram() async {
    return await _repository.getAllObject();
  }

  Future<Object> getProgramById(String id) async {
    return await _repository.getObjectById(id);
  }

  Future postProgram(Object obj) async {
    return await _repository.postObject(obj);
  }

  Future deleteProgram(String id) async {
    return await _repository.deleteObjectById(id);
  }
}
