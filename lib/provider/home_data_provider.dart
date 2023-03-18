import 'package:flutter/material.dart';
import 'package:notificator/model/company.dart';

import '../model/home_response.dart';
import '../repository/home_rempository.dart';

class HomeDataProvider with ChangeNotifier {
  bool _success = false;

  Company _company = Company();

  List<Group> _groups = [];

  List<NotificationData> _notifications = [];

  int _totalGroup = 0;

  int _totalEmployee = 0;

  int _totalNotifications = 0;

  String _error = '';

  // getters for the private variables
  bool get success => _success;

  List<Group> get groups => _groups;

  List<NotificationData> get notifications => _notifications;

  int get totalGroup => _totalGroup;

  int get totalEmployee => _totalEmployee;

  int get totalNotifications => _totalNotifications;

  Company get company => _company;

  String get error => _error;

  final HomeRepository _homeRepository = HomeRepository();

  /// This method is for submitting the email to the repository
  Future<void> getData(String token) async {
    try {
      final response = await _homeRepository.getData(token);
      print('EmployeeListProvider::: $_success');
      _success = response.success ?? false;

      if (success) {
        _company = response.company ?? Company();
        _groups = response.group ?? [];
        _notifications = response.notification ?? [];
        _totalGroup = response.totalGroup ?? 0;
        _totalEmployee = response.totalEmployee ?? 0;
        _totalNotifications = response.totalNotifications ?? 0;

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
