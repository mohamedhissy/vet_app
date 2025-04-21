import 'package:shared_preferences/shared_preferences.dart';

class AppSettingsSharedPreferences {
  static final _instance = AppSettingsSharedPreferences._internal();
  late SharedPreferences _sharedPreferences;

  AppSettingsSharedPreferences._internal();

  factory AppSettingsSharedPreferences() {
    return _instance;
  }

  Future<void> initPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  clear() {
    _sharedPreferences.clear();
  }
}
