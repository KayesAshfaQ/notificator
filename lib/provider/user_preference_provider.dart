import 'package:flutter/foundation.dart';

import '../util/share_pref_helper.dart';

class UserPreferenceProvider extends ChangeNotifier {
  String? _username;
  String? _userImg;

  String? get username => _username;

  String? get userImg => _userImg;

  Future<void> getData(String username, String userImg) async {
    _username = await SharedPreferencesHelper.getData(
        username); // Retrieve user token from shared preferences
    _userImg = await SharedPreferencesHelper.getData(userImg);
    if (kDebugMode) print('get Data: $_username');
    notifyListeners();
  }
}
