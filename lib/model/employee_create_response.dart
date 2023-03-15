import '../util/utils.dart';

class EmployeeCreateResponse {
  bool? success;
  EmployeeCreateResponseData? data;
  String? errors;
  String? message;

  EmployeeCreateResponse({
    this.success,
    this.data,
    this.errors,
    this.message,
  });

  factory EmployeeCreateResponse.fromJson(Map<String, dynamic> json) {
    bool isSuccess = json['success'] ?? false;

    if (isSuccess) {
      return EmployeeCreateResponse(
        success: json["success"],
        data: EmployeeCreateResponseData.fromJson(json["data"]),
      );
    } else {
      return EmployeeCreateResponse(
        errors: Utils.errorString(json['errors']),
        message: json['message'],
      );
    }
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
      };
}

class EmployeeCreateResponseData {
  EmployeeCreateResponseData({
    required this.userId,
    required this.companyId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.position,
    required this.empId,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  int userId;
  int companyId;
  String firstName;
  String lastName;
  String email;
  String position;
  String empId;
  DateTime updatedAt;
  DateTime createdAt;
  int id;

  factory EmployeeCreateResponseData.fromJson(Map<String, dynamic> json) =>
      EmployeeCreateResponseData(
        userId: json["user_id"],
        companyId: json["company_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        position: json["position"],
        empId: json["emp_id"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "company_id": companyId,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "position": position,
        "emp_id": empId,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
      };
}
