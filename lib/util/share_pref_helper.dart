import 'package:shared_preferences/shared_preferences.dart';
import 'keys.dart';

class SharedPreferencesHelper {
  static Future<void> setUserToken(String userToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(Keys.authToken, userToken);
  }

  static Future<String?> getUserToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(Keys.authToken);
  }
}
