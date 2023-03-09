import 'package:notificator/util/utils.dart';

class UpdateGroupResponse {
  final bool success;
  final GroupUpdateResponseData? data;
  final String? errors;

  UpdateGroupResponse({required this.success, this.data, this.errors});

  factory UpdateGroupResponse.fromJson(Map<String, dynamic> json) {
    if (json['success'] == false) {
      return UpdateGroupResponse(
        success: json['success'],
        errors: Utils.errorString(json['errors']),
      );
    } else {
      return UpdateGroupResponse(
        success: json['success'],
        data: GroupUpdateResponseData.fromJson(json['data']),
      );
    }
  }
}

// for handle data when response success
class GroupUpdateResponseData {
  final String name;
  final String userId;
  final String companyId;
  final String updatedAt;
  final String createdAt;
  final int id;

  GroupUpdateResponseData(
      {required this.name,
        required this.userId,
        required this.companyId,
        required this.updatedAt,
        required this.createdAt,
        required this.id});

  factory GroupUpdateResponseData.fromJson(Map<String, dynamic> json) {
    return GroupUpdateResponseData(
      name: json['name'],
      userId: json['user_id'],
      companyId: json['company_id'],
      updatedAt: json['updated_at'],
      createdAt: json['created_at'],
      id: json['id'],
    );
  }
}
