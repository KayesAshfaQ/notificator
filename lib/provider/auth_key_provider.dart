import 'package:flutter/material.dart';

import '../util/share_pref_helper.dart';

class AuthKeyProvider extends ChangeNotifier {
  String? _userToken;

  String? get userToken => _userToken;

  void setUserToken(String userToken) {
    _userToken = userToken;
    SharedPreferencesHelper.setUserToken(
        userToken); // Store user token in shared preferences
    notifyListeners();
  }

  Future<void> getUserToken() async {
    _userToken = await SharedPreferencesHelper
        .getUserToken(); // Retrieve user token from shared preferences
    notifyListeners();
  }
}
