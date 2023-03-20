/*// To parse this JSON data, do
//
//     final employeeHomeResponse = employeeHomeResponseFromJson(jsonString);

import 'dart:convert';

EmployeeHomeResponse employeeHomeResponseFromJson(String str) => EmployeeHomeResponse.fromJson(json.decode(str));

String employeeHomeResponseToJson(EmployeeHomeResponse data) => json.encode(data.toJson());*/

import 'package:notificator/model/notification_data.dart';

class EmployeeHomeResponse {
  bool? success;
  Employee? employee;
  List<Group>? group;
  List<NotificationData>? notification;

  EmployeeHomeResponse({
    this.success,
    this.employee,
    this.group,
    this.notification,
  });

  factory EmployeeHomeResponse.fromJson(Map<String, dynamic> json) =>
      EmployeeHomeResponse(
        success: json["success"],
        employee: json["employee"] == null
            ? null
            : Employee.fromJson(json["employee"]),
        group: json["group"] == null
            ? []
            : List<Group>.from(json["group"]!.map((x) => Group.fromJson(x))),
        notification: json["notification"] == null
            ? []
            : List<NotificationData>.from(json["notification"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "employee": employee?.toJson(),
        "group": group == null
            ? []
            : List<dynamic>.from(group!.map((x) => x.toJson())),
        "notification": notification == null
            ? []
            : List<dynamic>.from(notification!.map((x) => x)),
      };
}

class Employee {
  Employee({
    this.id,
    this.userId,
    this.companyId,
    this.photo,
    this.firstName,
    this.lastName,
    this.empId,
    this.email,
    this.phone,
    this.position,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? userId;
  String? companyId;
  String? photo;
  String? firstName;
  String? lastName;
  String? empId;
  String? email;
  String? phone;
  String? position;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        id: json["id"],
        userId: json["user_id"],
        companyId: json["company_id"],
        photo: json["photo"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        empId: json["emp_id"],
        email: json["email"],
        phone: json["phone"],
        position: json["position"],
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
        "photo": photo,
        "first_name": firstName,
        "last_name": lastName,
        "emp_id": empId,
        "email": email,
        "phone": phone,
        "position": position,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Group {
  Group({
    this.groupId,
    this.groupName,
  });

  String? groupId;
  String? groupName;

  factory Group.fromJson(Map<String, dynamic> json) => Group(
        groupId: json["group_id"],
        groupName: json["group_name"],
      );

  Map<String, dynamic> toJson() => {
        "group_id": groupId,
        "group_name": groupName,
      };
}
