import 'package:flutter/material.dart';
import 'package:notificator/model/notification_send_response.dart';
import 'package:notificator/repository/fcm_repository.dart';

import '../repository/auth_repository.dart';

class FirebaseNotificationSendProvider with ChangeNotifier {
  int _success = 0;
  String? _error;

  int get success => _success;

  String? get error => error;

  final FcmRepository _notificationRepository = FcmRepository();

  Future<void> sendNotification({
    required String token,
    required String title,
    required String body,
    required String notificationId,
    required String badge,
  }) async {
    try {
      final response = await _notificationRepository.sendIndividual(
        token: token,
        body: body,
        title: title,
        notificationId: notificationId,
        badge: badge,
      );
      _success = (response.success ?? false) as int;

      notifyListeners();
    } catch (e) {
      _error = e.toString();
      print(_error);
      notifyListeners();
    }
  }
}
