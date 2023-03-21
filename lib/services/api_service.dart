import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class CustomHttp extends http.BaseClient {
  final http.Client _inner = http.Client();

  Future<Map<String, String>> setAuthHeaders() async {
    Map<String, String> headMap = new Map();
    const storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'accessToken');
    headMap = {'Authorization': 'Bearer $token'};
    return headMap;
  }

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    request.headers.addAll(await setAuthHeaders());
    return _inner.send(request);
  }
}
