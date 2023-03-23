import 'package:flutter/material.dart';
import 'package:notificator/model/setting_data.dart';

import '../repository/setting_repository.dart';

class SettingDataSendProvider with ChangeNotifier {
  bool _success = false;
  String _error = '';
  SettingData? _setting;

  bool get success => _success;

  String get error => _error;

  SettingData? get createData => _setting;

  final SettingRepository _settingRepository = SettingRepository();

  /// This method is for creating new group
  Future<void> send(String token, String key, String switchState) async {
    print(key);

    try {
      final response = await _settingRepository.postData(
        token,
        key,
        switchState,
      );
      _success = response.success!;

      if (success) {
        _setting = response.data ?? SettingData();
      } else {
        _error = 'response errors!';
      }
      notifyListeners();
    } catch (e) {
      print(e.toString());
      _success = false;
      _error = e.toString();
      notifyListeners();
    }
  }
}
