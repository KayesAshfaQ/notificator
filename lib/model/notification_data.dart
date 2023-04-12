class NotificationData {
  NotificationData({
    this.id,
    this.userId,
    this.subject,
    this.message,
    this.readStatus,
    this.groupIndividual,
    this.groupIndividualIds,
    this.groupIndividualName,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? userId;
  String? subject;
  String? message;
  String? readStatus;
  String? groupIndividual;
  String? groupIndividualIds;
  String? groupIndividualName;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory NotificationData.fromJson(Map<String, dynamic> json) =>
      NotificationData(
        id: json["id"],
        userId: json["user_id"],
        subject: json["subject"],
        message: json["message"],
        readStatus: json["read_status"],
        groupIndividual: json["group_individual"],
        groupIndividualIds: json["group_individual_ids"],
        groupIndividualName: json["group_individual_name"],
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
        "subject": subject,
        "message": message,
        "group_individual": groupIndividual,
        "group_individual_ids": groupIndividualIds,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
