// To parse this JSON data, do
//
//     final empUpdateResponse = empUpdateResponseFromJson(jsonString);

import 'dart:convert';

//EmpUpdateResponse empUpdateResponseFromJson(String str) => EmpUpdateResponse.fromJson(json.decode(str));

//String empUpdateResponseToJson(EmpUpdateResponse data) => json.encode(data.toJson());

class EmpUpdateResponse {
  EmpUpdateResponse({
    this.success,
    this.data,
  });

  bool? success;
  Data? data;

  factory EmpUpdateResponse.fromJson(Map<String, dynamic> json) => EmpUpdateResponse(
    success: json["success"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
  };
}

class Data {
  Data({
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
  dynamic photo;
  String? firstName;
  String? lastName;
  String? empId;
  String? email;
  String? phone;
  String? position;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
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
