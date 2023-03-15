import 'dart:convert';

import 'package:notificator/model/employee.dart';
import 'package:notificator/model/employee_create_response.dart';
import 'package:notificator/model/employee_delete_response.dart';
import 'package:notificator/model/employee_list_response.dart';

import '../constants/app_info.dart';
import 'package:http/http.dart' as http;

class EmployeeRepository {
  /// This method is create new employee
  Future<EmployeeCreateResponse> create(Employee employee, String token) async {
    final url = Uri.parse('$kBaseUrl/employees');
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: {
        'first_name': employee.firstName,
        'last_name': employee.lastName,
        'email': employee.email,
        'position': employee.position,
        'password': employee.password,
      },
    );

    //print(response.statusCode);
    final data = json.decode(response.body);
    print(data);
    if (response.body.isNotEmpty) {
      final responseSuccess = EmployeeCreateResponse.fromJson(data);
      return responseSuccess;
    } else {
      throw Exception('failed!');
    }
  }

  /// This method is for getting the employees
  Future<EmployeeListResponse> getEmployees(String token) async {
    final url = Uri.parse('$kBaseUrl/employees');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    final data = json.decode(response.body);
    print(data);

    if (response.body.isNotEmpty) {
      final groupList = EmployeeListResponse.fromJson(data);
      print(groupList);
      return groupList;
    } else {
      throw Exception('failed!');
    }
  }

  /// This method is for getting the employees
  Future<EmployeeDeleteResponse> delete(int id, String token) async {
    final url = Uri.parse('$kBaseUrl/employees/$id');
    final response = await http.delete(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    final data = json.decode(response.body);
    print(data);

    if (response.body.isNotEmpty) {
      final groupList = EmployeeDeleteResponse.fromJson(data);
      print(groupList);
      return groupList;
    } else {
      throw Exception('failed!');
    }
  }
}
