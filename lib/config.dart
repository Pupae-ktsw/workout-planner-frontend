import 'package:frontend/controllers/program_controller.dart';
import 'package:frontend/models/program.dart';
import 'package:frontend/repositories/program_repo.dart';

class Config {
  static const String appName = "Workout Planner";
  // base url http://localhost:5000 or http://127.0.0.1:5000
  static const String apiURL = "http://10.0.2.2:5000"; //emulator
  // static const String apiURL = "http://192.168.43.243:5000"; //real device
  static const String loginAPI = "/users/login";
  static const String signupAPI = "/users/signup";
  static const String userAPI = "$apiURL/users";
  static const String eventAPI = "$apiURL/calendarEvents";
  static const String programAPI = "$apiURL/programs";
  static const String dayOfProgramAPI = "$apiURL/dayofprograms";
  static const String programSuggestAPI = "$apiURL/programs/suggest";
}
