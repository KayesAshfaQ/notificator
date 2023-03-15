import 'package:flutter/material.dart';

import '../util/share_pref_helper.dart';

class PreferenceProvider extends ChangeNotifier {
  String? _value;

  String? get userToken => _value;

  void setData(String key, String value) {
    _value = userToken;
    SharedPreferencesHelper.setData(
      ' data',
      'token',
    ); // Store user token in shared preferences
    notifyListeners();
  }

  void removeData(String key) {
    _value = null;
    SharedPreferencesHelper.removeToken(
      key,
    ); // Remove user token from shared preferences
    notifyListeners();
  }

  Future<void> getData(String key) async {
    _value = await SharedPreferencesHelper.getData(
      key,
    ); // Retrieve user token from shared preferences
    notifyListeners();
  }
}
