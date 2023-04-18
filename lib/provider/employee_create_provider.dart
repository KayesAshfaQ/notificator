import 'package:flutter/material.dart';

import '../model/employee.dart';
import '../model/employee_create_response.dart';
import '../repository/employee_repository.dart';

class EmployeeCreateProvider with ChangeNotifier {
  bool _success = false;
  String _error = '';
  EmployeeCreateResponseData? _data;

  bool get success => _success;

  String get error => _error;

  EmployeeCreateResponseData? get data => _data;

  final EmployeeRepository _employeeRepository = EmployeeRepository();

  /// This method is for creating new group
  Future<void> create(Employee employee, String token) async {
    try {
      final response = await _employeeRepository.create(employee, token);
      _success = response.success ?? false;

      if (success) {
        _data = response.data;
      } else {
        _error = response.errors!;
      }
      notifyListeners();
    } catch (e) {
      //print('EmployeeCreateProvider:::${e.toString()}');
      _success = false;
      _error = e.toString();
      notifyListeners();
    }
  }
}
