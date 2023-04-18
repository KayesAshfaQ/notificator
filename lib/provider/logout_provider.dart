import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../repository/auth_repository.dart';

class LogoutProvider with ChangeNotifier {
  bool _success = false;
  String _message = '';
  String _error = '';

  bool get success => _success;

  String get message => _message;

  String get error => _error;

  final AuthRepository _loginRepository = AuthRepository();

  Future<void> logout(String token) async {
    try {
      final response = await _loginRepository.logout(token);
      _success = response.success ?? false;

      if (success) {
        _message = response.message;
      } else {
        _error = response.errors ?? '';
      }
      notifyListeners();
    } catch (e) {
      _success = false;
      _error = e.toString();
      if (kDebugMode) print(_error);
      notifyListeners();
    }
  }
}
