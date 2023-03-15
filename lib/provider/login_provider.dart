import 'package:flutter/material.dart';
import 'package:notificator/model/company.dart';

import '../model/login_response.dart';
import '../repository/auth_repository.dart';

class LoginProvider with ChangeNotifier {
  bool _success = false;
  String _error = '';
  String _token = '';
  LoginSuccessResponseData? _data;

  bool get success => _success;

  String get error => _error;

  String get token => _token;

  LoginSuccessResponseData? get data => _data;

  final AuthRepository _loginRepository = AuthRepository();

  Future<void> login(String email, String password) async {
    try {
      final response = await _loginRepository.login(email, password);
      _success = response.success;

      if (success) {
        _token = response.token ?? '';
        _data = response.data;
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
