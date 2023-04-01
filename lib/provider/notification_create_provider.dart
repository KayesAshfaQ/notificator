import 'package:flutter/material.dart';
import 'package:notificator/model/notification_data.dart';

import '../repository/notification_repository.dart';

class NotificationCreateProvider with ChangeNotifier {
  bool _success = false;
  String _error = '';
  List<String>? _token;
  int? _id;
  String? _message;

  bool get success => _success;

  String get error => _error;

  List<String>? get token => _token;

  int? get id => _id;

  String? get data => _message;

  final NotificationRepository _notificationRepository =
      NotificationRepository();

  /// This method is for creating new group
  Future<void> create(NotificationData notification, String token) async {
    try {
      final response = await _notificationRepository.send(notification, token);
      _success = response.success ?? false;

      if (success) {
        _message = response.message;
      } else {
        _error = response.errors ?? 'notification send failed';
      }
      notifyListeners();
    } catch (e) {
      print('EmployeeCreateProvider:::${e.toString()}');
      _success = false;
      _error = e.toString();
      notifyListeners();
    }
  }
}
