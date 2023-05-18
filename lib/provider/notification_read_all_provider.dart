import 'package:flutter/foundation.dart';
import 'package:notificator/repository/notification_repository.dart';

class NotificationReadAllProvider with ChangeNotifier {
  bool _success = false;
  String _message = '';
  String _error = '';

  bool get success => _success;

  String get message => _message;

  String get error => _error;

  final NotificationRepository _groupRepository = NotificationRepository();

  /// This method is for get message after read all notifications
  Future<void> readAll(String token) async {
    try {
      final response = await _groupRepository.readAllNotifications(token);
      _success = response.success ?? false;

      if (success) {
        _message = response.message ?? '';
        notifyListeners();
      }else{
        _error = response.errors?.message ?? '';
        print('$_error');
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
