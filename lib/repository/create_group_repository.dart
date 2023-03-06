import 'dart:convert';

import 'package:notificator/model/login_error.dart';

import '../constants/app_info.dart';
import 'package:http/http.dart' as http;

import '../model/crate_group_response.dart';

class CreateGroupRepository {
  /// This method is used to submit the email to the server to send the password reset link
  Future<dynamic> create(String name, String token) async {
    final url = Uri.parse('$kBaseUrl/groups');
    final response = await http.post(
      url,
      body: {'name': name},
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    //print(response.statusCode);
    final data = json.decode(response.body);
    print(data);
    if (response.statusCode == 200) {
      final responseSuccess = CreateGroupResponseSuccess.fromJson(data);
      return responseSuccess;
    } else if (response.statusCode >= 400 && response.statusCode < 500) {
      final responseError = LoginResponseError.fromJson(data);
      return responseError;
    } else {
      throw Exception('failed!');
    }
  }
}
