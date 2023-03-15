import 'package:flutter/material.dart';

import '../repository/auth_repository.dart';

class PassChangeProvider with ChangeNotifier {
  bool _success = false;
  String _message = '';
  String _error = '';

  bool get success => _success;

  String get message => _message;

  String get error => _error;

  final AuthRepository _loginRepository = AuthRepository();

  Future<void> logout(String token, String oldPass, String newPass) async {
    try {
      final response = await _loginRepository.changePassword(
        token,
        oldPass,
        newPass,
      );
      _success = response.success;

      if (success) {
        _message = response.message;
      } else {
        _error = response.message;
      }
      notifyListeners();
    } catch (e) {
      _success = false;
      _error = e.toString();
      print(_error);
      notifyListeners();
    }
  }
}
