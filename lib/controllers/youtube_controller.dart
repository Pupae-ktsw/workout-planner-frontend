import '../repositories/repository.dart';

class YoutubeController {
  final Repository _repository;

  YoutubeController(this._repository);
  Future<List<Object>> getSearchVid(String keyword) async {
    return await _repository.getAllObjectById(keyword);
  }
}
