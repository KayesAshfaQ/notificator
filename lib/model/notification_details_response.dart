import 'package:notificator/model/notification_data.dart';

class NotificationDetailsResponse {
  bool? success;
  NotificationData? data;
  String? errors;

  NotificationDetailsResponse({
    this.success,
    this.data,
    this.errors,
  });

  factory NotificationDetailsResponse.fromJson(Map<String, dynamic> json) {
    final isSuccessful = json["success"] ?? false;

    if (isSuccessful) {
      return NotificationDetailsResponse(
        success: json["success"],
        data: json["data"] == null
            ? null
            : NotificationData.fromJson(json["data"]),
      );
    } else {
      return NotificationDetailsResponse(
        success: json["success"],
        errors: json["errors"],
      );
    }
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
      };
}
