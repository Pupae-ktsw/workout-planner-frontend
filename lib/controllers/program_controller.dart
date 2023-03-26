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
}
