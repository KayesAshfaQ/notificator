import 'dart:convert';

import 'package:notificator/model/login_response.dart';

import '../constants/app_info.dart';
import 'package:http/http.dart' as http;

class LoginRepository {
  Future<LoginResponse> login(String email, String password) async {
    final url = Uri.parse('$kBaseUrl/login');
    final response = await http.post(
      url,
      body: {
        'email': email,
        'password': password,
      },
    );

    final data = json.decode(response.body);
    print(data);

    if (response.body.isNotEmpty) {
      final responseSuccess = LoginResponse.fromJson(data);
      return responseSuccess;
    } else {
      throw Exception('Failed to login');
    }
  }
}
