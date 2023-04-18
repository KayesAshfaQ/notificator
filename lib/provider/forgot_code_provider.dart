import 'package:flutter/foundation.dart';
import 'package:notificator/repository/forgot_pass_repository.dart';

class ForgotCodeProvider with ChangeNotifier {
  bool _success = false;
  String _error = '';
  String _message = '';
  int? _code;

  bool get success => _success;

  String get error => _error;

  String get message => _message;

  int? get code => _code;

  final ForgotPassRepository _forgotPassRepository = ForgotPassRepository();

  /// This method is for submitting the email to the repository
  Future<void> submit(String email, String code) async {
    if (kDebugMode) print(email);

    try {
      final response = await _forgotPassRepository.sendCode(email, code);
      _success = response.success ?? false;

      if (success) {
        _message = response.message ?? '';
      } else {
        final error = response.errors;

        _error = (error?.verificationCode == null
                ? error?.message
                : error?.message) ??
            'failed!';
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
