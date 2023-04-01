import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:notificator/constants/routes.dart';
import 'package:notificator/model/fcm_notification_response.dart';

import '../constants/app_info.dart';

class FcmRepository {
  /// This method is for send notification to FIREBASE
  Future<FcmNotificationResponse> sendIndividual({
    required String token,
    required String body,
    required String title,
    required String notificationId,
    required String badge,
  }) async {
    final url = Uri.parse('$kBaseUrl/notifications');
    final response = await http.post(
      url,
      body: {
        "to": token,
        "notification": {
          "body": body,
          "title": title,
          "sound": "default",
          "badge": badge,
        },
        "data": {
          "screen_name": kRouteNotificationDetails,
          "notification_id": notificationId,
        },
        "direct_boot_ok": true,
        "time_to_live": 60
      },
      headers: {
        'Authorization': 'Bearer $fcmToken',
      },
    );

    //print(response.statusCode);
    final data = json.decode(response.body);
    print(data);
    if (response.statusCode == 200 && response.body.isNotEmpty) {
      final responseSuccess = FcmNotificationResponse.fromJson(data);
      return responseSuccess;
    } else {
      throw Exception('failed!');
    }
  }
}
