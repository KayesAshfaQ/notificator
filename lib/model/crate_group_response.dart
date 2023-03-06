/*
{
"success": true,
  "data": {
    "name": "Fang",
    "user_id": 1,
    "company_id": 4,
    "updated_at": "2023-03-06T12:01:48.000000Z",
    "created_at": "2023-03-06T12:01:48.000000Z",
    "id": 5
  }
}*/

class CreateGroupResponseSuccess {
  final bool success;
  final CrateGroupResponseData data;

  CreateGroupResponseSuccess({required this.success, required this.data});

  factory CreateGroupResponseSuccess.fromJson(Map<String, dynamic> json) {
    return CreateGroupResponseSuccess(
      success: json['success'],
      data: CrateGroupResponseData.fromJson(json['data']),
    );
  }
}

class CrateGroupResponseData {
  final String name;
  final int userId;
  final int companyId;
  final String updatedAt;
  final String createdAt;
  final int id;

  CrateGroupResponseData(
      {required this.name,
      required this.userId,
      required this.companyId,
      required this.updatedAt,
      required this.createdAt,
      required this.id});

  factory CrateGroupResponseData.fromJson(Map<String, dynamic> json) {
    return CrateGroupResponseData(
      name: json['name'],
      userId: json['user_id'],
      companyId: json['company_id'],
      updatedAt: json['updated_at'],
      createdAt: json['created_at'],
      id: json['id'],
    );
  }
}
