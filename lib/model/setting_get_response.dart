import 'package:notificator/model/setting_data.dart';

class SettingGetResponse {
  SettingGetResponse({
    this.success,
    this.data,
  });

  bool? success;
  List<SettingData>? data;

  factory SettingGetResponse.fromJson(Map<String, dynamic> json) =>
      SettingGetResponse(
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<SettingData>.from(
                json["data"]!.map(
                  (x) => SettingData.fromJson(x),
                ),
              ),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}
