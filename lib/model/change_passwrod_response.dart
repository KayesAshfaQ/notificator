class LogoutResponse {
  bool? success;
  String message;

  LogoutResponse({this.success, required this.message});

  factory LogoutResponse.fromJson(Map<String, dynamic> json) {
    return LogoutResponse(
      success: json['success'],
      message: json['message'],
    );
  }
}
