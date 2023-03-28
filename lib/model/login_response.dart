class LoginResponse {
  bool success;
  LoginSuccessResponseData? data;
  String? token;
  int? employeeId;
  int? companyId;
  String? imageUrl;
  LoginErrorResponseData? errors;

  LoginResponse({
    required this.success,
    this.token,
    this.data,
    this.employeeId,
    this.companyId,
    this.imageUrl,
    this.errors,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    if (json['success'] == false) {
      return LoginResponse(
        success: json['success'],
        errors: LoginErrorResponseData.fromJson(json['errors']),
      );
    } else {
      return LoginResponse(
        success: json['success'],
        token: json['token'],
        data: LoginSuccessResponseData.fromJson(json['data']),
        employeeId: json["employee_id"],
        companyId: json["company_id"],
        imageUrl: json["image_url"],
      );
    }
  }
}

// for handle error response
class LoginErrorResponseData {
  String? message;

  LoginErrorResponseData({this.message});

  factory LoginErrorResponseData.fromJson(Map<String, dynamic> json) {
    return LoginErrorResponseData(message: json['message']);
  }
}

class LoginSuccessResponseData {
  LoginSuccessResponseData({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.type,
    this.verificationCode,
  });

  int? id;
  String? name;
  String? email;
  dynamic emailVerifiedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? type;
  String? verificationCode;

  factory LoginSuccessResponseData.fromJson(Map<String, dynamic> json) =>
      LoginSuccessResponseData(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        type: json["type"],
        verificationCode: json["verification_code"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "type": type,
        "verification_code": verificationCode,
      };
}
