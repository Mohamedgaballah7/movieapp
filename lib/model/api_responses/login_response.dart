/// message : "Success Login"
/// data : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY4YTllNDcyNzU1M2U3N2U1YTRmOWYxNSIsImVtYWlsIjoiYW1yNDUyQGdtYWlsLmNvbSIsImlhdCI6MTc1NTk2NDU1N30.jqls5bphOPPFaDtAXOTFj-sTqYGig6CSXLxiakcTDUg"

class LoginResponse {
  LoginResponse({this.message, this.data});

  LoginResponse.fromJson(dynamic json) {
    message = json['message'];
    data = json['data'];
  }

  String? message;
  String? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['data'] = data;
    return map;
  }
}
