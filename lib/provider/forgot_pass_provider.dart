import 'package:flutter/material.dart';
import 'package:notificator/repository/forgot_pass_repository.dart';

class ForgotPassProvider with ChangeNotifier {
  bool _success = false;
  String _error = '';
  String _message = '';

  bool get success => _success;

  String get error => _error;

  String get token => _message;

  final ForgotPassRepository _forgotPassRepository = ForgotPassRepository();

  /// This method is for submitting the email to the repository
  Future<void> submit(String email) async {
    print(email);

    try {
      final response = await _forgotPassRepository.submit(email);
      _success = response.success;

      if (success) {
        _message = response.message;
      } else {
        _error = response.errors.message ?? 'failed!';
      }
      notifyListeners();
    } catch (e) {
      _success = false;
      _error = e.toString();
      notifyListeners();
    }
  }
}
