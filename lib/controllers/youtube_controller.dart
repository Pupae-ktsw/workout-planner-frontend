import '../repositories/repository.dart';

class YoutubeController {
  final Repository _repository;

  YoutubeController(this._repository);
  Future<List<Object>> getSearchVid(String keyword) async {
    return await _repository.getAllObjectByKeyword(keyword);
  }

  Future<List<Object>> getVidInPlayList(String id) async {
    return await _repository.getAllObjectById(id);
  }
}
