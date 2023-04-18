import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:notificator/repository/employee_update_repository.dart';

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
  Future<void> updateByAdmin(Employee employee, String token, int id) async {
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
      if (kDebugMode) print('EmployeeUpdateProvider:::${e.toString()}');
      _success = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  /// This method is for creating new group
  Future<void> updateByEmployee(
    Employee employee,
    String token,
    String id,
  ) async {
    try {
      final response = await EmployeeUpdateRepository().update(
        employee,
        token,
        id,
      );
      _success = response.success ?? false;

      if (success) {
        _data = response.data;
      } else {
        _error = 'response.errors!';
      }
      notifyListeners();
    } catch (e) {
      if (kDebugMode) print('EmployeeUpdateProvider:::${e.toString()}');
      _success = false;
      _error = e.toString();
      notifyListeners();
    }
  }
}
