import '../util/utils.dart';

class EmployeeListResponse {
  bool? success;
  List<EmployeeListResponseData>? data;
  String? errors;

  EmployeeListResponse({
    required this.success,
    this.data,
    this.errors,
  });

  factory EmployeeListResponse.fromJson(Map<String, dynamic> json) {
    bool isSuccess = json['success'] ?? false;

    if (isSuccess) {
      return EmployeeListResponse(
        success: json["success"],
        data: List<EmployeeListResponseData>.from(
          json["data"]!.map((x) => EmployeeListResponseData.fromJson(x)),
        ),
      );
    } else {
      return EmployeeListResponse(
        success: json["success"],
        errors: Utils.errorString(json['errors']),
      );
    }
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class EmployeeListResponseData {
  EmployeeListResponseData({
    required this.id,
    required this.userId,
    required this.companyId,
    this.groupInfo,
    this.photo,
    required this.firstName,
    required this.lastName,
    required this.empId,
    required this.email,
    this.phone,
    required this.position,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  int? id;
  int? userId;
  int? companyId;
  GroupInfo? groupInfo;
  dynamic photo;
  String? firstName;
  String? lastName;
  String? empId;
  String? email;
  String? phone;
  String? position;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory EmployeeListResponseData.fromJson(Map<String, dynamic> json) =>
      EmployeeListResponseData(
        id: json["id"],
        userId: json["user_id"],
        companyId: json["company_id"],
        groupInfo: json["group_info"] == null
            ? null
            : GroupInfo.fromJson(json["group_info"]),
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

class GroupInfo {
  GroupInfo({
    this.id,
    this.name,
  });

  List<int>? id;
  List<String>? name;

  factory GroupInfo.fromJson(Map<String, dynamic> json) => GroupInfo(
        id: json["id"] == null ? [] : List<int>.from(json["id"]!.map((x) => x)),
        name: json["name"] == null
            ? []
            : List<String>.from(json["name"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? [] : List<dynamic>.from(id!.map((x) => x)),
        "name": name == null ? [] : List<dynamic>.from(name!.map((x) => x)),
      };
}
