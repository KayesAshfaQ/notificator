import 'package:flutter/foundation.dart';
import 'package:notificator/repository/forgot_pass_repository.dart';

class ForgotPassProvider with ChangeNotifier {
  bool _success = false;
  String _error = '';
  String _message = '';
  int? _code;

  bool get success => _success;

  String get error => _error;

  String get token => _message;

  int? get code => _code;

  final ForgotPassRepository _forgotPassRepository = ForgotPassRepository();

  /// This method is for submitting the email to the repository
  Future<void> submit(String email) async {
    if (kDebugMode) print(email);

    try {
      final response = await _forgotPassRepository.submit(email);
      _success = response.success;

      if (success) {
        _message = response.message ?? '';
        _code = response.code ?? 0;
      } else {
        _error = response.errors ?? 'failed!';
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
