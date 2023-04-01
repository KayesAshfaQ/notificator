import 'dart:convert';

import 'package:notificator/model/change_passwrod_response.dart';
import 'package:notificator/model/login_response.dart';
import 'package:notificator/model/simple_response.dart';

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
  Future<SimpleResponse> logout(String token) async {
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
      final responseSuccess = SimpleResponse.fromJson(data);
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

  /// this function is used to logout the user
  Future<ChangePassResponse> resetPassword(
    String email,
    String code,
    String pass,
  ) async {
    final url = Uri.parse('$kBaseUrl/confirmreset');
    final response = await http.post(
      url,
      body: {
        'email': email,
        'verification_code': code,
        'password': pass,
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

  /// this function is used to put the user firebase token to the server
  Future<SimpleResponse> sendFirebaseToken(
    String token,
    String id,
    String firebaseToken,
  ) async {
    final url = Uri.parse('$kBaseUrl/employee/updatedevice/$id');
    final response = await http.put(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: {
        'device_token': firebaseToken,
      },
    );

    final data = json.decode(response.body);
    print(data);

    if (response.body.isNotEmpty) {
      final responseSuccess = SimpleResponse.fromJson(data);
      return responseSuccess;
    } else {
      throw Exception('Failed to change password');
    }
  }
}
