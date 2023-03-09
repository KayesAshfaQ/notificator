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

  int id;
  String userId;
  String companyId;
  String? photo;
  String firstName;
  String lastName;
  String empId;
  String email;
  String? phone;
  String position;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  factory EmployeeListResponseData.fromJson(Map<String, dynamic> json) =>
      EmployeeListResponseData(
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
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
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
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
