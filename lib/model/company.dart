class Company {
  int? id;
  String? userId;
  String? logo;
  String? name;
  String? phone;
  String? email;
  String? address;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  Company({
    this.id,
    this.userId,
    this.logo,
    this.name,
    this.phone,
    this.email,
    this.address,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        id: json["id"],
        userId: json["user_id"],
        logo: json["logo"],
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
        address: json["address"],
        status: json["status"],
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
        "logo": logo,
        "name": name,
        "phone": phone,
        "email": email,
        "address": address,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
