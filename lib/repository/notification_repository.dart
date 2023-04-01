import 'dart:convert';

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
  Future<NotificationListResponse> getNotifications(String token) async {
    final url = Uri.parse('$kBaseUrl/notifications');

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
      String token) async {
    final url = Uri.parse('$kBaseUrl/notification/empnotificationlist');

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
  Future<NotificationListResponse> searchNotifications(String token) async {
    final url = Uri.parse('$kBaseUrl/notifications/search');

    final response = await http.post(url, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      'search': 'search',
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

    url = Uri.parse('$kBaseUrl/notifications/details/$id');

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

/*
  /// This method is for delete the group by id
  Future<GroupDeleteResponse> delete(int id, token) async {
    final url = Uri.parse('$kBaseUrl/groups/$id');
    final response = await http.delete(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    //print(response.statusCode);
    final data = json.decode(response.body);
    print(data);
    if (response.body.isNotEmpty) {
      return GroupDeleteResponse.fromJson(data);
    } else {
      throw Exception('Failed to login');
    }
  }

  /// This method is used to update the group name
  Future<UpdateGroupResponse> update({required String name, required String token, required int id}) async {
    final url = Uri.parse('$kBaseUrl/groups/$id');
    final response = await http.put(
      url,
      body: {'name': name},
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    //print(response.statusCode);
    final data = json.decode(response.body);
    print('update:::$data');
    if (response.body.isNotEmpty) {
      final responseSuccess = UpdateGroupResponse.fromJson(data);
      return responseSuccess;
    } else {
      throw Exception('failed!');
    }
  }*/
}
