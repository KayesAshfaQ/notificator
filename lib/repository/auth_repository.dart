import 'dart:convert';

import 'package:notificator/model/change_passwrod_response.dart';
import 'package:notificator/model/login_response.dart';
import 'package:notificator/model/logout_response.dart';

import '../constants/app_info.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
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

  /// this function is used to logout the user
  Future<LogoutResponse> logout(String token) async {
    final url = Uri.parse('$kBaseUrl/logout');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    final data = json.decode(response.body);
    print(data);

    if (response.body.isNotEmpty) {
      final responseSuccess = LogoutResponse.fromJson(data);
      return responseSuccess;
    } else {
      throw Exception('Failed to logout');
    }
  }

  /// this function is used to logout the user
  Future<ChangePassResponse> changePassword(
    String token,
    String oldPass,
    String newPass,
  ) async {
    final url = Uri.parse('$kBaseUrl/changepassword');
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: {
        'old_password': oldPass,
        'new_password': newPass,
      },
    );

    final data = json.decode(response.body);
    print(data);

    if (response.body.isNotEmpty) {
      final responseSuccess = ChangePassResponse.fromJson(data);
      return responseSuccess;
    } else {
      throw Exception('Failed to change password');
    }
  }
}
