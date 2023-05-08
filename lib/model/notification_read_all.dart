class ReadAllNotificationResponse {
  bool? success;
  String? message;
  Errors? errors;

  ReadAllNotificationResponse({
    this.success,
    this.message,
    this.errors,
  });

  factory ReadAllNotificationResponse.fromJson(Map<String, dynamic> json) =>
      ReadAllNotificationResponse(
        success: json["success"],
        message: json["message"],
        errors: json["errors"] == null ? null : Errors.fromJson(json["errors"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "errors": errors?.toJson(),
      };
}

class Errors {
  String? message;

  Errors({
    this.message,
  });

  factory Errors.fromJson(Map<String, dynamic> json) => Errors(
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
