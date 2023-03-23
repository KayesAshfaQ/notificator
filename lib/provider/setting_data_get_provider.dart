import 'package:flutter/material.dart';
import 'package:notificator/model/setting_data.dart';

import '../constants/setting_constants.dart';
import '../repository/setting_repository.dart';

class SettingDataGetProvider with ChangeNotifier {
  bool _success = false;
  String _error = '';
  List<SettingData> _settings = [];

  bool _mailNotification = false;

  bool _pushNotification = false;

  bool get success => _success;

  String get error => _error;

  List<SettingData> get settingsData => _settings;

  bool get mailNotification => _mailNotification;

  bool get pushNotification => _pushNotification;

  final SettingRepository _settingRepository = SettingRepository();

  /// This method is for fetch setting data from the server
  Future<void> getData(String token) async {
    try {
      final response = await _settingRepository.getData(token);
      _success = response.success!;

      if (success) {
        _settings = response.data ?? [];

        if (_settings.isNotEmpty) {
          for (var data in _settings) {
            if (data.key == SettingConstants.keyReceiveMailNotification) {
              _mailNotification =
                  data.value == SettingConstants.switchOn ? true : false;
            }

            if (data.key == SettingConstants.keyReceivePushNotification) {
              _pushNotification =
                  data.value == SettingConstants.switchOn ? true : false;
            }
          }
        }
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

  /// This method is for send setting data to the server
  Future<void> setData(String token, String key, String value) async {
    try {
      // 1. Update the local data
      if (key == SettingConstants.keyReceiveMailNotification) {
        _mailNotification = value == SettingConstants.switchOn ? true : false;
        print('mailNotification: $_mailNotification');
      }
      if (key == SettingConstants.keyReceivePushNotification) {
        _pushNotification = value == SettingConstants.switchOn ? true : false;
        print('pushNotification: $_pushNotification');
      }

      // 2. Send the data to the server
      final response = await _settingRepository.postData(
        token,
        key,
        value,
      );
      _success = response.success!;

      // 3. check the response
      if (success) {
        SettingData? data = response.data;
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
