import 'package:notificator/util/utils.dart';

class ChangePassResponse {
  bool success;
  String message;
  final String? errors;

  ChangePassResponse({
    required this.success,
    required this.message,
    this.errors,
  });

  factory ChangePassResponse.fromJson(Map<String, dynamic> json) {
    if (json['success'] == true) {
      return ChangePassResponse(
        success: json['success'],
        message: json['message'],
      );
    } else {
      return ChangePassResponse(
        success: json['success'],
        message: Utils.errorString(json['errors']),
      );
    }
  }
}

/*{
"success": true,
"message": "Password changed successfully!"
}*/
