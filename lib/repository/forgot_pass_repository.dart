import 'dart:convert';

import 'package:notificator/model/login_error.dart';

import '../constants/app_info.dart';
import 'package:http/http.dart' as http;

import '../model/forgot_pass_success.dart';

class ForgotPassRepository {

  /// This method is used to submit the email to the server to send the password reset link
  Future<dynamic> submit(String email) async {
    final url = Uri.parse('$kBaseUrl/forgotpassword');
    final response = await http.post(
      url,
      body: {'email': email},
    );

    //print(response.statusCode);
    final data = json.decode(response.body);
    print(data);
    if (response.statusCode == 200) {
      final responseSuccess = ForgotPassResponseSuccess.fromJson(data);
      return responseSuccess;
    } else if (response.statusCode >= 400 && response.statusCode < 500) {
      final responseError = LoginResponseError.fromJson(data);
      return responseError;
    } else {
      throw Exception('Failed to login');
    }
  }
}
