import 'package:notificator/util/utils.dart';

class ForgotPassResponse {
  final bool success;
  final String? message;
  final String? errors;

  ForgotPassResponse({
    required this.success,
    this.message,
    this.errors,
  });

  factory ForgotPassResponse.fromJson(Map<String, dynamic> json) {
    if (json['success'] == false) {
      return ForgotPassResponse(
        success: json['success'],
        errors: Utils.errorString(json['errors']),
      );
    } else {
      return ForgotPassResponse(
        success: json['success'],
        message: json['message'],
      );
    }
  }
}
