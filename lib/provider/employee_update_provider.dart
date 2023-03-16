import 'package:flutter/material.dart';

import '../model/employee.dart';
import '../model/employee_update_response.dart';
import '../repository/employee_repository.dart';

class EmployeeUpdateProvider with ChangeNotifier {
  bool _success = false;
  String _error = '';
  Data? _data;

  bool get success => _success;

  String get error => _error;

  Data? get data => _data;

  final EmployeeRepository _employeeRepository = EmployeeRepository();

  /// This method is for creating new group
  Future<void> update(Employee employee, String token, int id) async {
    try {
      final response = await _employeeRepository.update(employee, token, id);
      _success = response.success ?? false;

      if (success) {
        _data = response.data;
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
