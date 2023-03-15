import 'package:notificator/util/utils.dart';

class EmployeeDeleteResponse {
  bool success;
  String? message = '';
  String? errors = '';

  EmployeeDeleteResponse({required this.success, this.message, this.errors});

  factory EmployeeDeleteResponse.fromJson(Map<String, dynamic> json) {
    if (json['success'] == false) {
      return EmployeeDeleteResponse(
        success: json['success'],
        errors: Utils.errorString(json['errors']),
      );
    } else {
      return EmployeeDeleteResponse(
        success: json['success'],
        message: json['message'],
      );
    }
  }
}
