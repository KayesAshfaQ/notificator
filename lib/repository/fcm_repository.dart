import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:notificator/constants/routes.dart';
import 'package:notificator/model/fcm_notification_response.dart';

import '../constants/app_info.dart';

class FcmRepository {
  /// This method is for send notification to FIREBASE
  Future<FcmNotificationResponse> sendIndividual({
    required String userToken,
    required String body,
    required String title,
    required String notificationId,
  }) async {

    final url = Uri.parse('https://fcm.googleapis.com/fcm/send');
    final response = await http.post(
      url,
      body: json.encode({
        "to": userToken,
        "notification": {
          "body": body,
          "title": title,
          "sound": "default",
          "badge": 0,
        },
        "data": {
          "screen_name": kRouteNotificationDetails,
          "notification_id": notificationId,
        },
        "direct_boot_ok": true,
        "time_to_live": 60
      }),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $fcmToken',
      },
    );
    //print(response.statusCode);
    final data = json.decode(response.body);
    if (kDebugMode) {
      print("FCM sendIndividual $data");
    }
    if (response.statusCode == 200 && response.body.isNotEmpty) {
      final responseSuccess = FcmNotificationResponse.fromJson(data);
      return responseSuccess;
    } else {
      throw Exception('failed!');
    }
  }

  Future<FcmNotificationResponse> sendGroup({
    required List<String>? userTokens,
    required String body,
    required String title,
    required String notificationId,
  }) async {

    final url = Uri.parse('https://fcm.googleapis.com/fcm/send');
    final response = await http.post(
      url,
      body: json.encode({
        "registration_ids": userTokens == null ? [] : List<dynamic>.from(userTokens.map((x) => x)),
        "notification": {
          "body": body,
          "title": title,
          "sound": "default",
        },
        "data": {
          "screen_name": kRouteNotificationDetails,
          "notification_id": notificationId,
        },
        "direct_boot_ok": true,
        "time_to_live": 60
      }),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $fcmToken',
      },
    );

    //print(response.statusCode);
    final data = json.decode(response.body);
    if (kDebugMode) {
      print("FCM sendGroup $data");
    }
    if (response.statusCode == 200 && response.body.isNotEmpty) {
      final responseSuccess = FcmNotificationResponse.fromJson(data);
      return responseSuccess;
    } else {
      throw Exception('failed!');
    }
  }
}
