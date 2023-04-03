import '../repositories/repository.dart';

class DayOfProgramController {
  final Repository _repository;

  DayOfProgramController(this._repository);

  Future<List<Object>> getDayOfProgram(String objId) async {
    return await _repository.getAllObjectById(objId);
  }

  Future<Object> updateDayOfProgram(Object obj) async {
    return await _repository.updateObject(obj);
  }
}
