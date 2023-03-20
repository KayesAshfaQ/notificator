import 'dart:convert';

import 'package:notificator/model/home_response_admin.dart';
import 'package:notificator/model/home_response_employee.dart';

import '../constants/app_info.dart';
import 'package:http/http.dart' as http;

class HomeRepository {
  /// This method is for fetching the admin home screen data
  Future<HomeResponse> getAdminData(String token) async {
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

  /// This method is for fetching the employee home screen data
  Future<EmployeeHomeResponse> getEmployeeData(String token) async {
    final url = Uri.parse('$kBaseUrl/home/employee');
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
      final responseSuccess = EmployeeHomeResponse.fromJson(data);
      return responseSuccess;
    } else {
      throw Exception('Failed to login');
    }
  }
}
