import 'dart:convert';

import '../constants/app_info.dart';
import 'package:http/http.dart' as http;

import '../model/forgot_pass_response.dart';

class ForgotPassRepository {
  /// This method is used to submit the email to the server to send the password reset link
  Future<ForgotPassResponse> submit(String email) async {
    final url = Uri.parse('$kBaseUrl/forgotpassword');
    final response = await http.post(
      url,
      body: {'email': email},
    );

    //print(response.statusCode);
    final data = json.decode(response.body);
    print(data);
    if (response.body.isNotEmpty) {
      final responseSuccess = ForgotPassResponse.fromJson(data);
      return responseSuccess;
    } else {
      throw Exception('Failed to login');
    }
  }
}
