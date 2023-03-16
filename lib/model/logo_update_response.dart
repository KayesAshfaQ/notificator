// To parse this JSON data, do
//
//     final d = dFromJson(jsonString);

import 'dart:convert';

class LogoUpdateResponse {
  bool? success;
  Data? data;

  LogoUpdateResponse({
    required this.success,
    this.data,
  });

  factory LogoUpdateResponse.fromJson(Map<String, dynamic> json) =>
      LogoUpdateResponse(
        success: json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
      };
}

class Data {
  String? logoUrl;

  Data({
    this.logoUrl,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        logoUrl: json["logo_url"],
      );

  Map<String, dynamic> toJson() => {
        "logo_url": logoUrl,
      };
}
