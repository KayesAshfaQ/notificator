class ForgotCodeResponse {
  bool? success;
  String? message;
  Errors? errors;

  ForgotCodeResponse({
    this.success,
    this.message,
    this.errors,
  });

  factory ForgotCodeResponse.fromJson(Map<String, dynamic> json) {
    if (json['success']) {
      return ForgotCodeResponse(
        success: json["success"],
        message: json["message"],
      );
    } else {
      return ForgotCodeResponse(
        success: json["success"],
        errors: json["errors"] == null ? null : Errors.fromJson(json["errors"]),
      );
    }
  }
}

class Errors {
  Errors({
    this.verificationCode,
    this.message,
  });

  String? verificationCode;
  String? message;

  factory Errors.fromJson(Map<String, dynamic> json) => Errors(
        message: json["message"],
        verificationCode: json["verification_code"] == null
            ? null
            : List<String>.from(json["verification_code"]!.map((x) => x)).first,
      );
}
