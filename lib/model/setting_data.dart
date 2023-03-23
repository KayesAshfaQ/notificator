
class SettingData {
  SettingData({
    this.id,
    this.userId,
    this.key,
    this.value,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  dynamic userId;
  String? key;
  String? value;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory SettingData.fromJson(Map<String, dynamic> json) => SettingData(
    id: json["id"],
    userId: json["user_id"],
    key: json["key"],
    value: json["value"],
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
    "key": key,
    "value": value,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
