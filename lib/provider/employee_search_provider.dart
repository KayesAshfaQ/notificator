import 'package:flutter/material.dart';
import 'package:notificator/repository/employee_repository.dart';

import '../model/employee_list_response.dart';

class EmployeeSearchProvider with ChangeNotifier {
  bool _success = false;
  String _error = '';
  List<EmployeeListResponseData>? _data;

  bool get success => _success;

  String get error => _error;

  List<EmployeeListResponseData>? get data => _data;

  final EmployeeRepository _employeeRepository = EmployeeRepository();

  /// This method is for submitting the email to the repository
  Future<void> search(String token, String searchText, String sort) async {
    try {
      final response =
          await _employeeRepository.search(token, searchText, sort);
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
