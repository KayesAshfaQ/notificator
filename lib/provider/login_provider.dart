import 'package:flutter/material.dart';

import '../repository/login_repository.dart';

class LoginProvider with ChangeNotifier {
  bool _success = false;
  String _error = '';
  String _token = '';

  bool get success => _success;

  String get error => _error;

  String get token => _token;

  final LoginRepository _loginRepository = LoginRepository();

  Future<void> login(String email, String password) async {
    try {
      final response = await _loginRepository.login(email, password);
      _success = response.success;

      if (success) {
        _token = response.data?.token ?? '';
      } else {
        _error = response.errors?.message ?? 'Login failed!';
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
