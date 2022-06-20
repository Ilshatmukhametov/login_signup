import 'package:shared_preferences/shared_preferences.dart';

class UpdateUserData {
  late final String name;
  late final String number;
  late final String email;
  late final String password;
  late SharedPreferences pref;

  UpdateUserData({required this.name, required this.number, required this.email, required this.password});


}