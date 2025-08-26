/// message : "Profile fetched successfully"
/// data : {"id":"68ab301e4ad29a01dc38547e","email":"amr82@gmail.com","password":"$2b$10$xITffkIMT3LVJ.T6y3YwA.F0dlHdVtn3H6dYcx/RviugKO88sqEH2","name":"amr mustafa","phone":"+201141209334","avaterId":1,"createdAt":"2025-08-24T15:30:38.201Z","updatedAt":"2025-08-24T15:30:38.201Z","_v":0}

class ProfileResponse {
  ProfileResponse({this.message, this.data, this.statusCode, this.error});

  ProfileResponse.fromJson(dynamic json) {
    message = json['message'];
    error = json['error'];
    statusCode = json['statusCode'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  String? message;
  Data? data;
  String? error;

  int? statusCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['error'] = error;
    map['statusCode '] = statusCode;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

/// _id : "68ab301e4ad29a01dc38547e"
/// email : "amr82@gmail.com"
/// password : "$2b$10$xITffkIMT3LVJ.T6y3YwA.F0dlHdVtn3H6dYcx/RviugKO88sqEH2"
/// name : "amr mustafa"
/// phone : "+201141209334"
/// avaterId : 1
/// createdAt : "2025-08-24T15:30:38.201Z"
/// updatedAt : "2025-08-24T15:30:38.201Z"
/// __v : 0

class Data {
  Data({
    this.id,
    this.email,
    this.password,
    this.name,
    this.phone,
    this.avaterId,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  Data.fromJson(dynamic json) {
    id = json['_id'];
    email = json['email'];
    password = json['password'];
    name = json['name'];
    phone = json['phone'];
    avaterId = json['avaterId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }

  String? id;
  String? email;
  String? password;
  String? name;
  String? phone;
  int? avaterId;
  String? createdAt;
  String? updatedAt;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['email'] = email;
    map['password'] = password;
    map['name'] = name;
    map['phone'] = phone;
    map['avaterId'] = avaterId;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    return map;
  }
}
