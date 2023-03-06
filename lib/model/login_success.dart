class LoginResponseSuccess {
  final bool success;
  final LoginResponseData data;

  LoginResponseSuccess({required this.success, required this.data});

  factory LoginResponseSuccess.fromJson(Map<String, dynamic> json) {
    return LoginResponseSuccess(
      success: json['success'],
      data: LoginResponseData.fromJson(json['data']),
    );
  }
}

class LoginResponseData {
  String token;
  int userId;

  LoginResponseData({required this.token, required this.userId});

  factory LoginResponseData.fromJson(Map<String, dynamic> json) {
    return LoginResponseData(
      token: json['token'],
      userId: json['user_id'],
    );
  }
}
