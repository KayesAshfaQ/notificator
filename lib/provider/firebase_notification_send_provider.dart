import 'package:flutter/foundation.dart';
import 'package:notificator/repository/fcm_repository.dart';

class FirebaseNotificationSendProvider with ChangeNotifier {
  int _success = 0;
  String? _error;

  int get success => _success;

  String? get error => error;

  final FcmRepository _notificationRepository = FcmRepository();

  Future<void> sendIndividualNotification({
    required String token,
    required String title,
    required String body,
    required String notificationId,
  }) async {

    if (kDebugMode) print('FCM firebase notification send provider');

    try {
      final response = await _notificationRepository.sendIndividual(
        userToken: token,
        body: body,
        title: title,
        notificationId: notificationId,
      );
      _success = (response.success ?? false) as int;

      notifyListeners();
    } catch (e) {
      _error = e.toString();
      if (kDebugMode) print(_error);
      notifyListeners();
    }
  }

  Future<void> sendGroupNotification({
    required List<String>? userTokens,
    required String title,
    required String body,
    required String notificationId,
  }) async {
    try {
      final response = await _notificationRepository.sendGroup(
        userTokens: userTokens,
        body: body,
        title: title,
        notificationId: notificationId,
      );
      _success = (response.success ?? false) as int;

      notifyListeners();
    } catch (e) {
      _error = e.toString();
      if (kDebugMode) print(_error);
      notifyListeners();
    }
  }
}
