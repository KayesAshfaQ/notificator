import 'dart:convert';

import 'package:notificator/model/home_response.dart';

import '../constants/app_info.dart';
import 'package:http/http.dart' as http;

class HomeRepository {
  /// This method is used to submit the email to the server to send the password reset link
  Future<HomeResponse> getData(String token) async {
    final url = Uri.parse('$kBaseUrl/homes');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    //print(response.statusCode);
    final data = json.decode(response.body);
    print('HOME_RESPONSE ::: $data');
    if (response.body.isNotEmpty) {
      final responseSuccess = HomeResponse.fromJson(data);
      return responseSuccess;
    } else {
      throw Exception('Failed to login');
    }
  }
}
