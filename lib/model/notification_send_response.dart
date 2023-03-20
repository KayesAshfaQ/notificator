import '../util/utils.dart';

class NotificationSendResponse {
  bool? success;
  String? message;
  String? errors;

  NotificationSendResponse({
    this.success,
    this.message,
    this.errors,
  });

  factory NotificationSendResponse.fromJson(Map<String, dynamic> json) {
    bool isSuccess = json['success'] ?? false;

    if (isSuccess) {
      return NotificationSendResponse(
        success: json["success"],
        message: json["message"],
      );
    } else {
      return NotificationSendResponse(
        message: json['message'],
        errors: Utils.errorString(json['errors']),
      );
    }
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
      };
}

class Errors {
  Errors({
    this.subject,
    this.message,
    this.groupIndividual,
    this.groupIndividualIds,
  });

  List<String>? subject;
  List<String>? message;
  List<String>? groupIndividual;
  List<String>? groupIndividualIds;

  factory Errors.fromJson(Map<String, dynamic> json) => Errors(
        subject: json["subject"] == null
            ? []
            : List<String>.from(json["subject"]!.map((x) => x)),
        message: json["message"] == null
            ? []
            : List<String>.from(json["message"]!.map((x) => x)),
        groupIndividual: json["group_individual"] == null
            ? []
            : List<String>.from(json["group_individual"]!.map((x) => x)),
        groupIndividualIds: json["group_individual_ids"] == null
            ? []
            : List<String>.from(json["group_individual_ids"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "subject":
            subject == null ? [] : List<dynamic>.from(subject!.map((x) => x)),
        "message":
            message == null ? [] : List<dynamic>.from(message!.map((x) => x)),
        "group_individual": groupIndividual == null
            ? []
            : List<dynamic>.from(groupIndividual!.map((x) => x)),
        "group_individual_ids": groupIndividualIds == null
            ? []
            : List<dynamic>.from(groupIndividualIds!.map((x) => x)),
      };
}
