import 'package:notificator/model/setting_data.dart';

class SettingPostResponse {
  bool? success;
  SettingData? data;

  SettingPostResponse({
    this.success,
    this.data,
  });

  factory SettingPostResponse.fromJson(Map<String, dynamic> json) =>
      SettingPostResponse(
        success: json["success"],
        data: json["data"] == null ? null : SettingData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
      };
}
