class NotificationSendResponse {
  bool? success;
  String? message;

  NotificationSendResponse({
    this.success,
    this.message,
  });

  factory NotificationSendResponse.fromJson(Map<String, dynamic> json) =>
      NotificationSendResponse(
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
      };
}
