import 'package:flutter/material.dart';
import 'package:notificator/model/notification_data.dart';
import 'package:notificator/model/notification_list_response.dart';
import 'package:notificator/repository/notification_repository.dart';

class NotificationListProvider with ChangeNotifier {
  bool _success = false;
  String _error = '';
  List<NotificationData>? _data;

  bool get success => _success;

  String get error => _error;

  List<NotificationData>? get data => _data;

  final NotificationRepository _notificationRepository =
      NotificationRepository();

  /// This method is for fetching the notifications form the repository
  Future<void> getList(String token, String userType) async {
    try {
      NotificationListResponse response;
      if (userType == '1') {
        response = await _notificationRepository.getNotifications(token);
      } else {
        response =
            await _notificationRepository.getNotificationsEmployee(token);
      }

      _success = response.success;

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

  /// This method is for fetching the notifications form the repository
  Future<void> notificationSearch(
      String token, String sort, String searchTxt) async {
    try {
      NotificationListResponse response;

      response = await _notificationRepository.search(token, sort, searchTxt);

      _success = response.success;

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
}
