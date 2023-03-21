import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:notificator/model/employee.dart';
import 'package:notificator/model/logo_update_response.dart';

import '../constants/app_info.dart';
import 'package:http/http.dart' as http;

import '../model/employee_update_response.dart';

class EmployeeUpdateRepository {
  /// This method is to Update employee info by employee
  Future<EmpUpdateResponse> update(
    Employee employee,
    String token,
    String id,
  ) async {


    print('EmpUpdateResponse::: 1');

    final url = Uri.parse('$kBaseUrl/employee/update/$id');
    final response = await http.put(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: {
        'first_name': employee.firstName,
        'last_name': employee.lastName,
        'email': employee.email,
        'phone': employee.phone,
      },
    );

    print('EmpUpdateResponse::: 2');

    //print(response.statusCode);
    final data = json.decode(response.body);


    print('EmpUpdateResponse::: 3');
    print(data);
    if (response.body.isNotEmpty) {

print('EmpUpdateResponse::: 4');

      final responseSuccess = EmpUpdateResponse.fromJson(data);
      return responseSuccess;
    } else {

print('EmpUpdateResponse::: 5');

      throw Exception('failed!');
    }

  }

  /// This method is to update employee photo
  Future<LogoUpdateResponse> updatePhoto(
    String token,
    String employeeId,
    File logo,
  ) async {
    // create url for the api call
    final url = Uri.parse('$kBaseUrl/employee/photoupdate');

    // create multipart request for the api call
    final request = http.MultipartRequest('POST', url);

    // Add the token as header
    request.headers.addAll({
      'Authorization': 'Bearer $token',
    });

    // Add the ID as a form field
    request.fields['employee_id'] = employeeId;

    // Add the logo to the form field
    final file = await http.MultipartFile.fromPath('photo', logo.path);
    request.files.add(file);

    // Send the request
    final streamedResponse = await request.send();

    // Get the response
    final response = await http.Response.fromStream(streamedResponse);

    //print
    debugPrint(response.body);

    if (response.body.isNotEmpty && response.statusCode == 200) {
      // decode the response
      final data = json.decode(response.body);

      final logoUpdateResponse = LogoUpdateResponse.fromJson(data);
      debugPrint(logoUpdateResponse.data!.logoUrl!);
      return logoUpdateResponse;
    } else {
      throw Exception('failed!');
    }
  }
}
