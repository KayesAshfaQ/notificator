import 'package:flutter/material.dart';
import 'package:notificator/model/email_config_response.dart';
import 'package:notificator/repository/setting_repository.dart';

class EmailConfigProvider with ChangeNotifier {
  bool _success = false;
  String _error = '';
  Config? _config;

  bool get success => _success;

  String get error => _error;

  Config? get data => _config;

  final SettingRepository _settingRepository = SettingRepository();

  /// This method is to get email configurations
  Future<void> getEmailConfig(String token) async {
    try {
      final response = await _settingRepository.getEmailConfig(token);
      _success = response.success ?? false;

      if (success) {
        _config = response.data;
      } else {
        _error = 'response.errors!';
      }
      notifyListeners();
    } catch (e) {
      print('EmployeeUpdateProvider:::${e.toString()}');
      _success = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  /// This method is for post email configuration
  Future<void> setEmailConfig(Config config, String token) async {
    try {
      final response = await _settingRepository.setConfig(config, token);
      _success = response.success ?? false;

      if (success) {
        _config = response.data;
      } else {
        _error = 'response.errors!';
      }
      notifyListeners();
    } catch (e) {
      print('EmployeeUpdateProvider:::${e.toString()}');
      _success = false;
      _error = e.toString();
      notifyListeners();
    }
  }
}
