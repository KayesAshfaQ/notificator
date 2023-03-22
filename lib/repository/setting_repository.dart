import 'dart:convert';

import '../constants/app_info.dart';
import 'package:http/http.dart' as http;

import '../model/email_config_response.dart';

class SettingRepository {
  /// This method is create new employee
  Future<EmailConfigResponse> setConfig(Config config, String token) async {
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
    print(data);
    if (response.body.isNotEmpty) {
      final responseSuccess = EmailConfigResponse.fromJson(data);
      return responseSuccess;
    } else {
      throw Exception('failed!');
    }
  }

  /// This method is create new employee
  Future<EmailConfigResponse> getEmailConfig(String token) async {
    final url = Uri.parse('$kBaseUrl/configurations');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    //print(response.statusCode);
    final data = json.decode(response.body);
    print(data);
    if (response.body.isNotEmpty && response.statusCode == 200) {
      final responseSuccess = EmailConfigResponse.fromJson(data);
      return responseSuccess;
    } else {
      throw Exception('failed!');
    }
  }


}
