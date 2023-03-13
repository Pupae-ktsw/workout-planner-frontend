// import 'dart:convert';

// import 'package:frontend/config.dart';
// // import 'package:frontend/models/login_model.dart';
// // import 'package:frontend/models/signup_model.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// class APIService {
//   Future loginUser(String email, String password) async {
//     final url = Config.apiURL + Config.loginAPI;

//     var response = await http
//         .post(Uri.parse(url), body: {"email": email, "password": password});
//     if (response.statusCode == 200) {
//       var token = json.decode(response.body);
//       // print(token['accessToken']);
//     } else {
//       throw Exception('Failed to login');
//     }
//   }

//   /*static var client = http.Client();

//   static Future<bool> login(LoginRequestModel model) async {
//     Map<String, String> reqHeader = {
//       'Content-Type': 'application/json',
//     };
//     var url = Uri.http(Config.apiURL, Config.loginAPI);

//     var response = await client.post(
//       url,
//       headers: reqHeader,
//       body: jsonEncode(model.toJson()),
//     );

//     if (response.statusCode == 200) {
//       final storage = FlutterSecureStorage();
//       storage.write(key: 'accessToken', value: value)
//       return true;
//     } else {
//       return false;
//     }
//   }

//   static Future<SignupResponseModel> signup(SignupRequestModel model) async {
//     Map<String, String> reqHeader = {
//       'Content-Type': 'application/json',
//     };
//     var url = Uri.http(Config.apiURL, Config.signupAPI);

//     var response = await client.post(
//       url,
//       headers: reqHeader,
//       body: jsonEncode(model.toJson()),
//     );

//     return signupResponseModel(response.body);

//     // if(response.statusCode == 200){

//     //   return true;
//     // }
//     // else {
//     //   return false;
//     // }
//   }*/
// }
