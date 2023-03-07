class LoginResponse {
  final bool success;
  final LoginSuccessResponseData? data;
  final LoginErrorResponseData? errors;

  LoginResponse({required this.success, this.errors, this.data});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    if (json['success'] == false) {
      return LoginResponse(
        success: json['success'],
        errors: LoginErrorResponseData.fromJson(json['errors']),
      );
    } else {
      return LoginResponse(
        success: json['success'],
        data: LoginSuccessResponseData.fromJson(json['data']),
      );
    }
  }
}

// for handle error response
class LoginErrorResponseData {
  String? message;

  LoginErrorResponseData({this.message});

  factory LoginErrorResponseData.fromJson(Map<String, dynamic> json) {
    return LoginErrorResponseData(message: json['message']);
  }
}

// for handle success response
class LoginSuccessResponseData {
  final String token;
  final int userId;

  LoginSuccessResponseData({required this.token, required this.userId});

  factory LoginSuccessResponseData.fromJson(Map<String, dynamic> json) {
    return LoginSuccessResponseData(
      token: json['token'],
      userId: json['user_id'],
    );
  }
}
