import 'package:notificator/util/utils.dart';

class GroupListResponse {
  bool success;
  List<GroupListResponseData>? data;
  String? errors = '';

  GroupListResponse({required this.success, this.data, this.errors});

  factory GroupListResponse.fromJson(Map<String, dynamic> json) {
    if (json['success'] == false) {
      return GroupListResponse(
        success: json['success'],
        errors: Utils.errorString(json['errors']),
      );
    } else {
      return GroupListResponse(
        success: json['success'] ?? false,
        data: json['data'] != null
            ? (json['data'] as List).map((i) => GroupListResponseData.fromJson(i)).toList()
            : null,
      );
    }
  }
}

// for handle data when response success
class GroupListResponseData {
  final String name;
  final String userId;
  final String companyId;
  final String updatedAt;
  final String createdAt;
  final int id;

  GroupListResponseData(
      {required this.name,
        required this.userId,
        required this.companyId,
        required this.updatedAt,
        required this.createdAt,
        required this.id});

  factory GroupListResponseData.fromJson(Map<String, dynamic> json) {
    return GroupListResponseData(
      name: json['name'],
      userId: json['user_id'],
      companyId: json['company_id'],
      updatedAt: json['updated_at'],
      createdAt: json['created_at'],
      id: json['id'],
    );
  }
}
