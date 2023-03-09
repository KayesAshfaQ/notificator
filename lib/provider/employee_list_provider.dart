import 'package:flutter/material.dart';
import 'package:notificator/repository/employee_repository.dart';

import '../model/employee_list_response.dart';
import '../model/group_list_response.dart';
import '../repository/group_repository.dart';

class EmployeeListProvider with ChangeNotifier {
  bool _success = false;
  String _error = '';
  List<EmployeeListResponseData>? _data;

  bool get success => _success;

  String get error => _error;

  List<EmployeeListResponseData>? get data => _data;

  final EmployeeRepository _employeeRepository = EmployeeRepository();

  /// This method is for submitting the email to the repository
  Future<void> getList(String token) async {
    try {
      final response = await _employeeRepository.getEmployees(token);
      print('EmployeeListProvider::: $_success');
      _success = response.success ?? false;

      if (success) {
        _data = response.data;
        notifyListeners();
      } else {
        _error = response.errors!;
        notifyListeners();
      }
    } catch (e) {
      print(e.toString());
      _success = false;
      _error = e.toString();
      notifyListeners();
    }
  }
}
