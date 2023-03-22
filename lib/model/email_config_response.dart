class EmailConfigResponse {
  bool? success;
  Config? data;

  EmailConfigResponse({
    this.success,
    this.data,
  });

  factory EmailConfigResponse.fromJson(Map<String, dynamic> json) =>
      EmailConfigResponse(
        success: json["success"],
        data: json["data"] == null ? null : Config.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
      };
}

class Config {
  int? id;
  dynamic userId;
  String? driver;
  String? host;
  String? port;
  String? encryption;
  String? userName;
  String? password;
  String? senderName;
  String? senderEmail;
  DateTime? createdAt;
  DateTime? updatedAt;

  Config({
    this.id,
    this.userId,
    this.driver,
    this.host,
    this.port,
    this.encryption,
    this.userName,
    this.password,
    this.senderName,
    this.senderEmail,
    this.createdAt,
    this.updatedAt,
  });

  factory Config.fromJson(Map<String, dynamic> json) => Config(
        id: json["id"],
        userId: json["user_id"],
        driver: json["driver"],
        host: json["host"],
        port: json["port"],
        encryption: json["encryption"],
        userName: json["user_name"],
        password: json["password"],
        senderName: json["sender_name"],
        senderEmail: json["sender_email"],
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
        "driver": driver,
        "host": host,
        "port": port,
        "encryption": encryption,
        "user_name": userName,
        "password": password,
        "sender_name": senderName,
        "sender_email": senderEmail,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
