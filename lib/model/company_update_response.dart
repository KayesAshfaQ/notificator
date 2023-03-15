import 'package:notificator/model/company.dart';

import '../util/utils.dart';

class CompanyUpdateResponse {
  bool success;
  Company? data;
  String? errors;

  CompanyUpdateResponse({
    required this.success,
    this.data,
    this.errors,
  });

  factory CompanyUpdateResponse.fromJson(Map<String, dynamic> json) {
    if (json["success"] == true) {
      return CompanyUpdateResponse(
        success: json["success"],
        data: json["data"] == null ? null : Company.fromJson(json["data"]),
      );
    } else {
      return CompanyUpdateResponse(
        success: json["success"],
        errors: Utils.errorString(json["errors"]),
      );
    }
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
      };
}
