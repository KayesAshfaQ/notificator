import 'package:flutter/material.dart';

import '../model/home_response_employee.dart';
import '../model/notification_data.dart';
import '../repository/home_rempository.dart';

class HomeEmployeeDataProvider with ChangeNotifier {
  bool _success = false;

  Employee _employee = Employee();

  List<Group> _groups = [];

  List<NotificationData> _notifications = [];

  String _error = '';

  // getters for the private variables
  bool get success => _success;

  List<Group> get groups => _groups;

  List<NotificationData> get notifications => _notifications;

  Employee get employee => _employee;

  String get error => _error;

  final HomeRepository _homeRepository = HomeRepository();

  /// This method is for submitting the email to the repository
  Future<void> getData(String token) async {
    try {
      final response = await _homeRepository.getEmployeeData(token);
      print('EmployeeListProvider::: $_success');
      _success = response.success ?? false;

      if (success) {
        _employee = response.employee ?? Employee();
        _groups = response.group ?? [];
        _notifications = response.notification ?? [];

        notifyListeners();
      } else {
        _error = 'Failed to get data';
        notifyListeners();
      }
    } catch (e) {
      print(e.toString());
      _success = false;
      //_error = e.toString();
      notifyListeners();
    }
  }
}
