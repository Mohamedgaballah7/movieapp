/// message : "Invalid or expired token"
/// error : "Unauthorized"
/// statusCode : 401

class ResetPasswordResponse {
  ResetPasswordResponse({
    this.message,
    this.error,
    this.statusCode,
    this.oldPassword,
    this.newPassword,
  });

  ResetPasswordResponse.fromJson(dynamic json) {
    message = json['message'];
    error = json['error'];
    statusCode = json['statusCode'];
    oldPassword = json['oldPassword'];
    newPassword = json['newPassword'];
  }

  String? message;
  String? error;
  int? statusCode;
  String? oldPassword;
  String? newPassword;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['error'] = error;
    map['statusCode'] = statusCode;
    map['oldPassword'] = oldPassword;
    map['newPassword'] = newPassword;
    return map;
  }
}
