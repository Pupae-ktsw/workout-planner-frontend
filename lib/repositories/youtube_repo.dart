import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:frontend/models/youtubeVid.dart';
import 'package:frontend/repositories/repository.dart';

import '../config.dart';
import '../services/api_service.dart';

class YoutubeRepo implements Repository {
  String url = Config.youtubeAPI;
  String url2 = Config.youtubePlayListAPI;
  var http = CustomHttp();

  @override
  Future<List<Object>> getAllObject() {
    // TODO: implement getAllObject
    throw UnimplementedError();
  }

  @override
  Future<List<Object>> getAllObjectById(String id) async {
    String urlPlaylist = url2 + "/" + id;
    List<YoutubeVid> vidList = [];

    var response = await http.get(Uri.parse(urlPlaylist));
    var body = json.decode(response.body);

    for (var i = 0; i < body.length; i++) {
      if (body[i] != null) {
        var vid = YoutubeVid.fromJson(body[i]);

        vidList.add(vid);
      }
    }

    return vidList;
  }

  @override
  Future<List<Object>> getAllObjectByKeyword(String keyword) async {
    String getBykeywordUrl = url + "/" + keyword;
    List<YoutubeVid> vidList = [];

    var response = await http.get(Uri.parse(getBykeywordUrl));
    var body = json.decode(response.body);

    for (var i = 0; i < body.length; i++) {
      if (body[i] != null) {
        var vid = YoutubeVid.fromJson(body[i]);

        vidList.add(vid);
      }
    }

    return vidList;
  }

  @override
  Future<Object> getObjectById(String id) {
    // TODO: implement getObjectById
    throw UnimplementedError();
  }

  @override
  Future postObject(Object obj) {
    // TODO: implement postObject
    throw UnimplementedError();
  }

  @override
  Future<Object> updateObject(Object obj) {
    // TODO: implement updateObject
    throw UnimplementedError();
  }

  @override
  Future<Object> getObject() {
    // TODO: implement getObject
    throw UnimplementedError();
  }

  @override
  Future deleteObjectById(String id) {
    // TODO: implement deleteObjectById
    throw UnimplementedError();
  }
}
