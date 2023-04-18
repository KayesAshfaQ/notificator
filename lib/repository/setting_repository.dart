import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:notificator/model/setting_get_response.dart';
import 'package:notificator/model/setting_post_response.dart';

import '../constants/app_info.dart';
import 'package:http/http.dart' as http;

import '../model/email_config_response.dart';

class SettingRepository {
  /// this is for get all settings data from server
  Future<SettingGetResponse> getData(String token) async {
    final url = Uri.parse('$kBaseUrl/settings');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    //print(response.statusCode);
    final data = json.decode(response.body);
    if (kDebugMode) print(data);
    if (response.body.isNotEmpty && response.statusCode == 200) {
      final responseSuccess = SettingGetResponse.fromJson(data);
      return responseSuccess;
    } else {
      throw Exception('failed!');
    }
  }

  /// this is for get all settings data from server
  Future<SettingPostResponse> postData(
      String token, String key, String switchState) async {
    final url = Uri.parse('$kBaseUrl/settings');
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: {
        'key': key,
        'value': switchState,
      },
    );

    //print(response.statusCode);
    final data = json.decode(response.body);
    if (kDebugMode) print(data);
    if (response.body.isNotEmpty && response.statusCode == 200) {
      final responseSuccess = SettingPostResponse.fromJson(data);
      return responseSuccess;
    } else {
      throw Exception('failed!');
    }
  }

  /// This method is create new employee
  Future<EmailConfigResponse> setSmtpConfig(Config config, String token) async {
    final url = Uri.parse('$kBaseUrl/configurations');
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: {
        'driver': config.driver,
        'hostName': config.host,
        'port': config.port,
        'encryption': config.encryption,
        'userName': config.userName,
        'password': config.password,
        'senderName': config.senderName,
        'senderEmail': config.senderEmail,
      },
    );

    //print(response.statusCode);
    final data = json.decode(response.body);
    if (kDebugMode) print(data);
    if (response.body.isNotEmpty) {
      final responseSuccess = EmailConfigResponse.fromJson(data);
      return responseSuccess;
    } else {
      throw Exception('failed!');
    }
  }

  /// This method is create new employee
  Future<EmailConfigResponse> getSmtpConfig(String token) async {
    final url = Uri.parse('$kBaseUrl/configurations');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    //print(response.statusCode);
    final data = json.decode(response.body);
    if (kDebugMode) print(data);
    if (response.body.isNotEmpty && response.statusCode == 200) {
      final responseSuccess = EmailConfigResponse.fromJson(data);
      return responseSuccess;
    } else {
      throw Exception('failed!');
    }
  }
}
