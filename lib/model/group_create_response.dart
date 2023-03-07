import 'package:notificator/util/utils.dart';

class CreateGroupResponse {
  final bool success;
  final CreateGroupResponseData? data;
  final String? errors;

  CreateGroupResponse({required this.success, this.data, this.errors});

  factory CreateGroupResponse.fromJson(Map<String, dynamic> json) {
    if (json['success'] == false) {
      return CreateGroupResponse(
        success: json['success'],
        errors: Utils.errorString(json['errors']),
      );
    } else {
      return CreateGroupResponse(
        success: json['success'],
        data: CreateGroupResponseData.fromJson(json['data']),
      );
    }
  }
}

// for handle data when response success
class CreateGroupResponseData {
  final String name;
  final int userId;
  final int companyId;
  final String updatedAt;
  final String createdAt;
  final int id;

  CreateGroupResponseData(
      {required this.name,
      required this.userId,
      required this.companyId,
      required this.updatedAt,
      required this.createdAt,
      required this.id});

  factory CreateGroupResponseData.fromJson(Map<String, dynamic> json) {
    return CreateGroupResponseData(
      name: json['name'],
      userId: json['user_id'],
      companyId: json['company_id'],
      updatedAt: json['updated_at'],
      createdAt: json['created_at'],
      id: json['id'],
    );
  }
}
