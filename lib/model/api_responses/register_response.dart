/// message : "User created successfully"
/// data : {"email":"youssefmohamed22@gmail.com","password":"$2b$10$1jrF2ZSWXcjJBeXAYz4fle8tWc63FOBp.IVuNQUWPfsbDAp5wHU.a","name":"youssef21","phone":"+201141209221","avaterId":2,"_id":"68a713b6eeaff735d603242d","createdAt":"2025-08-21T12:40:22.544Z","updatedAt":"2025-08-21T12:40:22.544Z","__v":0}

class RegisterResponse {
  RegisterResponse({this.message, this.data, this.statusCode});

  RegisterResponse.fromJson(dynamic json) {
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  String? message;
  Data? data;
  int? statusCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['statusCode'] = statusCode;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

/// email : "youssefmohamed22@gmail.com"
/// password : "$2b$10$1jrF2ZSWXcjJBeXAYz4fle8tWc63FOBp.IVuNQUWPfsbDAp5wHU.a"
/// name : "youssef21"
/// phone : "+201141209221"
/// avaterId : 2
/// _id : "68a713b6eeaff735d603242d"
/// createdAt : "2025-08-21T12:40:22.544Z"
/// updatedAt : "2025-08-21T12:40:22.544Z"
/// __v : 0

class Data {
  Data({
    this.email,
    this.password,
    this.name,
    this.phone,
    this.avaterId,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  Data.fromJson(dynamic json) {
    email = json['email'];
    password = json['password'];
    name = json['name'];
    phone = json['phone'];
    avaterId = json['avaterId'];
    id = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }

  String? email;
  String? password;
  String? name;
  String? phone;
  int? avaterId;
  String? id;
  String? createdAt;
  String? updatedAt;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    map['password'] = password;
    map['name'] = name;
    map['phone'] = phone;
    map['avaterId'] = avaterId;
    map['_id'] = id;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    return map;
  }
}
