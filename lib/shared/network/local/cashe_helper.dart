// ignore_for_file: import_of_legacy_library_into_null_safe
import 'package:shared_preferences/shared_preferences.dart';

class CasheHelper {
   static late SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }


// ignore: unnecessary_question_mark
  static dynamic getData({required dynamic key}) {
    return sharedPreferences.get(key);
  }

  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is bool) return await sharedPreferences.setBool(key, value);
    if (value is int) return await sharedPreferences.setInt(key, value);
    if (value is String) return await sharedPreferences.setString(key, value);
    return await sharedPreferences.setDouble(key, value);
  }
  static Future<bool> removeData({
    required String key,
  })async
  {
   return await sharedPreferences.remove(key);
}
  static Future<bool> clearData()async
  {
    return await sharedPreferences.clear();
  }


}
