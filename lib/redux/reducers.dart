import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/redux/app_state.dart';

import 'actions.dart';

late SharedPreferences pref;
AppState reducer(AppState state, dynamic action) {
  if (action is UpdateUserData) {
    pref = SharedPreferences.getInstance() as SharedPreferences;
    String names = pref.getString('name').toString();
    return AppState(name: names, number: action.number, email: action.email, password: action.password);
  } else {
    return state;
  }
}