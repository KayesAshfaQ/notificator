import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../util/share_pref_helper.dart';

class PreferenceProvider extends ChangeNotifier {
  String? _data;

  String? get data => _data;

  void setData(String key, String value) {
    _data = data;
    SharedPreferencesHelper.setData(
      key,
      value,
    ); // Store user token in shared preferences
    notifyListeners();
  }

  void removeData(String key) {
    _data = null;
    SharedPreferencesHelper.removeToken(
      key,
    ); // Remove user token from shared preferences
    notifyListeners();
  }

  Future<void> getData(String key) async {
    _data = await SharedPreferencesHelper.getData(
      key,
    ); // Retrieve user token from shared preferences
    if (kDebugMode) print('get Data: $_data');
    notifyListeners();
  }
}
