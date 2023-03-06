class LoginResponseError {
  final bool success;
  final LoginResponseData errors;

  LoginResponseError({required this.success, required this.errors});

  factory LoginResponseError.fromJson(Map<String, dynamic> json) {
    return LoginResponseError(
      success: json['success'],
      errors: LoginResponseData.fromJson(json['errors']),
    );
  }
}

class LoginResponseData {
  String message;

  LoginResponseData({required this.message});

  factory LoginResponseData.fromJson(Map<String, dynamic> json) {
    return LoginResponseData(message: json['message']);
  }
}
