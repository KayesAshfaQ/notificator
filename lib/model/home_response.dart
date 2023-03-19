import 'company.dart';
import 'notification_data.dart';

class HomeResponse {
  HomeResponse({
    this.success,
    this.company,
    this.group,
    this.notification,
    this.totalGroup,
    this.totalEmployee,
    this.totalNotifications,
  });

  bool? success;
  Company? company;
  List<Group>? group;
  List<NotificationData>? notification;
  int? totalGroup;
  int? totalEmployee;
  int? totalNotifications;

  factory HomeResponse.fromJson(Map<String, dynamic> json) => HomeResponse(
        success: json["success"],
        company:
            json["company"] == null ? null : Company.fromJson(json["company"]),
        group: json["group"] == null
            ? []
            : List<Group>.from(json["group"]!.map((x) => Group.fromJson(x))),
        notification: json["notification"] == null
            ? []
            : List<NotificationData>.from(
                json["notification"]!.map((x) => NotificationData.fromJson(x))),
        totalGroup: json["total_group"],
        totalEmployee: json["total_employee"],
        totalNotifications: json["total_notifications"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "company": company?.toJson(),
        "group": group == null
            ? []
            : List<dynamic>.from(group!.map((x) => x.toJson())),
        "notification": notification == null
            ? []
            : List<dynamic>.from(notification!.map((x) => x)),
        "total_group": totalGroup,
        "total_employee": totalEmployee,
        "total_notifications": totalNotifications,
      };
}

class Group {
  Group({
    this.id,
    this.userId,
    this.companyId,
    this.name,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? userId;
  String? companyId;
  String? name;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Group.fromJson(Map<String, dynamic> json) => Group(
        id: json["id"],
        userId: json["user_id"],
        companyId: json["company_id"],
        name: json["name"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "company_id": companyId,
        "name": name,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
