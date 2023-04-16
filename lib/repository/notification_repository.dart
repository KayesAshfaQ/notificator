import 'dart:convert';

import 'package:notificator/model/notificaiton_count_response.dart';
import 'package:notificator/model/notification_data.dart';
import 'package:notificator/model/notification_details_response.dart';
import 'package:notificator/model/notification_list_response.dart';
import 'package:notificator/model/notification_send_response.dart';

import '../constants/app_info.dart';
import 'package:http/http.dart' as http;

class NotificationRepository {
  /// This method is for send notification to the group
  Future<NotificationSendResponse> send(
      NotificationData notification, String token) async {
    final url = Uri.parse('$kBaseUrl/notifications');

    final response = await http.post(
      url,
      body: {
        'subject': notification.subject,
        'message': notification.message,
        'group_individual': notification.groupIndividual,
        'group_individual_ids': notification.groupIndividualIds,
      },
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    //print(response.statusCode);
    final data = json.decode(response.body);
    print(data);
    if (response.statusCode == 200 && response.body.isNotEmpty) {
      final responseSuccess = NotificationSendResponse.fromJson(data);
      return responseSuccess;
    } else {
      throw Exception('failed!');
    }
  }

  /// This method is for getting the notification list from admin
  Future<NotificationListResponse> getNotifications(
      String token, int? limit, int? page) async {
    Uri url;
    if (limit != null && page != null) {
      url = Uri.parse('$kBaseUrl/notifications?per_page=$limit&page=$page');
    } else {
      url = Uri.parse('$kBaseUrl/notifications');
    }

    print(url);

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    final data = json.decode(response.body);
    print(data);
    //print('NotificationList::: ${response.statusCode}');

    if (response.body.isNotEmpty) {
      final notificationList = NotificationListResponse.fromJson(data);
      print(notificationList);
      return notificationList;
    } else {
      print('NotificationList::: 6');

      throw Exception('failed!');
    }
  }

  /// This method is for getting the notification list by employee
  Future<NotificationListResponse> getNotificationsEmployee(
      String token, int? limit, int? page) async {
    Uri url;
    if (limit != null && page != null) {
      url = Uri.parse(
          '$kBaseUrl/notification/empnotificationlist?per_page=$limit&page=$page');
    } else {
      url = Uri.parse('$kBaseUrl/notification/empnotificationlist');
    }

    print(url);

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    final data = json.decode(response.body);

    print(data);
    //print('NotificationList::: ${response.statusCode}');

    if (response.body.isNotEmpty) {
      final notificationList = NotificationListResponse.fromJson(data);
      print(notificationList);
      return notificationList;
    } else {
      print('NotificationList::: 6');

      throw Exception('failed!');
    }
  }

  /// This method is to sort/filter notifications
  Future<NotificationListResponse> search(String token, String sort,
      String searchTxt, String? isRead, int page) async {
    final url =
        Uri.parse('$kBaseUrl/notifications/search?per_page=50&page=$page');
    print(url);

    final response = await http.post(url, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      'user_ids': '',
      'group_ids': '',
      'sort': sort,
      'search_text': searchTxt,
      'is_read': isRead ?? '',
    });

    final data = json.decode(response.body);

    print(data);
    //print('NotificationList::: ${response.statusCode}');

    if (response.body.isNotEmpty) {
      final notificationList = NotificationListResponse.fromJson(data);
      print(notificationList);
      return notificationList;
    } else {
      print('NotificationList::: 6');

      throw Exception('failed!');
    }
  }

  /// This method is for getting the notification details
  Future<NotificationDetailsResponse> getNotificationDetails(
      String token, String id) async {
    Uri url;

    url = Uri.parse('$kBaseUrl/notification/details/$id');
    print(url);

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    final data = json.decode(response.body);

    print(data);
    //print('NotificationList::: ${response.statusCode}');

    if (response.body.isNotEmpty) {
      final notificationList = NotificationDetailsResponse.fromJson(data);
      print(notificationList);
      return notificationList;
    } else {
      print('NotificationList::: 6');

      throw Exception('failed!');
    }
  }

  /// This method is for getting the unread notification count
  Future<NotificationCountResponse> getNotificationCount(String token) async {
    Uri url;

    url = Uri.parse('$kBaseUrl/employee/notificationcount');
    print(url);

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    final data = json.decode(response.body);

    print(data);
    //print('NotificationList::: ${response.statusCode}');

    if (response.body.isNotEmpty) {
      final notificationList = NotificationCountResponse.fromJson(data);
      print(notificationList);
      return notificationList;
    } else {
      throw Exception('failed!');
    }
  }
}
