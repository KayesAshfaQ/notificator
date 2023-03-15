import 'package:shared_preferences/shared_preferences.dart';
import 'keys.dart';

class SharedPreferencesHelper {
  /// Method to store user token in shared preferences
  static Future<void> setUserToken(String userToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(Keys.authToken, userToken);
  }

  /// Method to retrieve user token from shared preferences
  static Future<String?> getUserToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(Keys.authToken);
  }

  /// Method to remove user token from shared preferences
  static Future<void> removeUserToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(Keys.authToken);
  }

  /// Generic method to store data in shared preferences
  static Future<void> setData(String userToken, String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, userToken);
  }

  /// Generic method to retrieve data from shared preferences
  static Future<String?> getData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  /// Generic method to remove data from shared preferences
  static Future<void> removeToken(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}
