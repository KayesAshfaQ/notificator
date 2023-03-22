import 'package:flutter/material.dart';
import 'package:notificator/model/notification_data.dart';
import 'package:notificator/repository/notification_repository.dart';

class NotificationDetailsProvider with ChangeNotifier {
  bool _success = false;
  String _error = '';
  NotificationData? _data;

  bool get success => _success;

  String get error => _error;

  NotificationData? get data => _data;

  final NotificationRepository _notificationRepository =
      NotificationRepository();

  /// This method is for fetching the notifications form the repository
  Future<void> getData(String token, String id) async {
    try {
      final response =
          await _notificationRepository.getNotificationDetails(token, id);
      _success = response.success ?? false;

      if (success) {
        _data = response.data;
        notifyListeners();
      } else {
        _error = 'Failed to fetch the notifications!';
        notifyListeners();
      }
    } catch (e) {
      print(e.toString());
      _success = false;
      _error = e.toString();
      notifyListeners();
    }
  }

void clearData() {
    _data = null;
    //notifyListeners();
  }

}
