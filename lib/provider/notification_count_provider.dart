import 'package:flutter/foundation.dart';
import 'package:notificator/repository/notification_repository.dart';

class NotificationCountProvider with ChangeNotifier {
  bool _success = false;
  int _count = 0;
  String _error = '';

  bool get success => _success;

  int get count => _count;

  String get error => _error;

  final NotificationRepository _groupRepository = NotificationRepository();

  /// This method is for count unread notifications
  Future<void> getCount(String token) async {
    try {
      final response = await _groupRepository.getNotificationCount(token);
      _success = response.success ?? false;

      if (success) {
        _count = response.count ?? 0;
        notifyListeners();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      _success = false;
      _error = e.toString();
      notifyListeners();
    }
  }
}
