import 'package:shared_preferences/shared_preferences.dart';

class Pref{
  static Future<bool> saveUserId(String user_id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString('user_id', user_id);
  }

  static Future<String> loadUserId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('user_id');
  }

  static Future<bool> removeUserId() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.remove('user_id');
  }
}