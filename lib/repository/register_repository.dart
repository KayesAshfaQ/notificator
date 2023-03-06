import 'dart:convert';

import '../constants/app_info.dart';
import '../model/user.dart';
import 'package:http/http.dart' as http;

class RegisterRepository {
  Future< /*User*/ bool> register(String email, String password) async {
    final url = Uri.parse('$kBaseUrl/login');
    final response = await http.post(
      url,
      body: {
        'email': email,
        'password': password,
      },
    );

    print(response.statusCode);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['success'];

      /*return User(
        id: data['id'],
        username: data['username'],
        email: data['email'],
        token: data['token'],
      );*/
    } else {
      throw Exception('Failed to login');
    }
  }
}
