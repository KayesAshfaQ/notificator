import 'package:notificator/model/notification_data.dart';

class NotificationListResponse {
  bool success;
  List<NotificationData>? data;
  int? total;
  int? perPage;
  int? currentPage;
  int? lastPage;

  NotificationListResponse({
    required this.success,
    this.data,
    this.total,
    this.perPage,
    this.currentPage,
    this.lastPage,
  });

  factory NotificationListResponse.fromJson(Map<String, dynamic> json) =>
      NotificationListResponse(
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<NotificationData>.from(
                json["data"]!.map((x) => NotificationData.fromJson(x))),
        total: json["total"],
        perPage: json["per_page"],
        currentPage: json["current_page"],
        lastPage: json["last_page"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "total": total,
        "per_page": perPage,
        "current_page": currentPage,
        "last_page": lastPage,
      };
}
