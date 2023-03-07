import 'package:notificator/util/utils.dart';

class GroupDeleteResponse {
  bool success;
  String? message;
  String? errors = '';

  GroupDeleteResponse({required this.success, this.message, this.errors});

  factory GroupDeleteResponse.fromJson(Map<String, dynamic> json) {
    if (json['success'] == false) {
      return GroupDeleteResponse(
        success: json['success'],
        errors: Utils.errorString(json['errors']),
      );
    } else {
      return GroupDeleteResponse(
        success: json['success'],
        errors: json['message'],
      );
    }
  }
}
