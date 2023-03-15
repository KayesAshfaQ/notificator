import 'dart:convert';

import 'package:notificator/model/company.dart';
import 'package:notificator/model/company_update_response.dart';
import 'package:notificator/model/employee.dart';
import 'package:notificator/model/employee_create_response.dart';
import 'package:notificator/model/employee_list_response.dart';

import '../constants/app_info.dart';
import 'package:http/http.dart' as http;

class CompanyRepository {
  /// This method is create new employee
  Future<CompanyUpdateResponse> update(Company company, String token, int id) async {
    final url = Uri.parse('$kBaseUrl/employees/$id');
    final response = await http.put(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: {
        'name': company.name,
        'phone': company.phone,
        'email': company.email,
        'address': company.address,
      },
    );

    //print(response.statusCode);
    final data = json.decode(response.body);
    print(data);
    if (response.body.isNotEmpty) {
      final responseSuccess = CompanyUpdateResponse.fromJson(data);
      return responseSuccess;
    } else {
      throw Exception('failed!');
    }
  }

 /* /// This method is for getting the employees
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
  Future<EmployeeListResponse> delete(int id, String token) async {
    final url = Uri.parse('$kBaseUrl/employees');
    final response = await http.delete(
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
  }*/


}
