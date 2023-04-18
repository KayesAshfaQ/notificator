import 'package:flutter/foundation.dart';
import 'package:notificator/repository/employee_repository.dart';

class EmployeeDeleteProvider with ChangeNotifier {
  bool _success = false;
  String _error = '';
  String _message = '';

  bool get success => _success;

  String get error => _error;

  String get message => _message;

  final EmployeeRepository _employeeRepository = EmployeeRepository();

  Future<void> delete(int id, String token) async {
    try {
      final response = await _employeeRepository.delete(id, token);
      _success = response.success;

      if (success) {
        _message = response.message ?? 'employee removed!';
        if (kDebugMode) print('GroupDeleteProvider:::$message');
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
