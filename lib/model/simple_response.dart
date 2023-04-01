import '../util/utils.dart';

class SimpleResponse {
  bool? success;
  String message;
  final String? errors;

  SimpleResponse({this.success, required this.message, this.errors});

  factory SimpleResponse.fromJson(Map<String, dynamic> json) {
    if (json['success'] == true) {
      return SimpleResponse(
        success: json['success'],
        message: json['message'],
      );
    } else {
      return SimpleResponse(
        success: json['success'],
        message: Utils.errorString(json['errors']),
      );
    }
  }
}
