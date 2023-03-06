import 'dart:convert';

import 'package:notificator/model/login_error.dart';
import 'package:notificator/model/login_success.dart';

import '../constants/app_info.dart';
import 'package:http/http.dart' as http;

class LoginRepository {
  Future<dynamic> login(String email, String password) async {
    final url = Uri.parse('$kBaseUrl/login');
    final response = await http.post(
      url,
      body: {
        'email': email,
        'password': password,
      },
    );

    //print(response.statusCode);
    final data = json.decode(response.body);
    print(data);
    if (response.statusCode == 200) {
      final responseSuccess = LoginResponseSuccess.fromJson(data);
      return responseSuccess;

      /*return User(
        id: data['id'],
        username: data['username'],
        email: data['email'],
        token: data['token'],
      );*/
    } else {
      //throw Exception('Failed to login');
      final responseError = LoginResponseError.fromJson(data);
      return responseError;
    }
  }
}
