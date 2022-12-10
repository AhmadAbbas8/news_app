import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static SharedPreferences? prefs;

  static init() async {
    prefs = await SharedPreferences.getInstance();
  }

 static Future<bool> putDataBool({required String key, required bool value}) async {
    return await prefs!.setBool(key, value);
  }

  static bool? getDataBool({required String key}) {
    return prefs!.getBool(key);
  }
}
