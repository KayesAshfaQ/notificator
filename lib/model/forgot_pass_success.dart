class ForgotPassResponseSuccess {
  final bool success;
  final String message;

  ForgotPassResponseSuccess({required this.success, required this.message});

  factory ForgotPassResponseSuccess.fromJson(Map<String, dynamic> json) {
    return ForgotPassResponseSuccess(
      success: json['success'],
      message: json['message'],
    );
  }
}
