class NotificationCountResponse {
  NotificationCountResponse({
    this.success,
    this.count,
  });

  bool? success;
  int? count;

  factory NotificationCountResponse.fromJson(Map<String, dynamic> json) =>
      NotificationCountResponse(
        success: json["success"],
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "count": count,
      };
}
