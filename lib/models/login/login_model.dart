class LoginModel {
  int? statusCode;
  Data? data;
  String? message;
  bool? success;

  LoginModel({this.statusCode, this.data, this.message, this.success});

  LoginModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonMap = {};
    jsonMap['statusCode'] = statusCode;
    if (data != null) {
      jsonMap['data'] = data!.toJson();
    }
    jsonMap['message'] = message;
    jsonMap['success'] = success;
    return jsonMap;
  }
}

class Data {
  User? user;
  String? accessToken;
  String? refreshToken;

  Data({this.user, this.accessToken, this.refreshToken});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonMap = {};
    if (user != null) {
      jsonMap['user'] = user!.toJson();
    }
    jsonMap['accessToken'] = accessToken;
    jsonMap['refreshToken'] = refreshToken;
    return jsonMap;
  }
}

class User {
  String? id;
  String? username;
  String? email;
  String? fullname;
  String? avatar;
  String? coverImage;
  List<dynamic>? watchHistory; // Empty array implies dynamic type
  String? createdAt;
  String? updatedAt;
  int? v;

  User({
    this.id,
    this.username,
    this.email,
    this.fullname,
    this.avatar,
    this.coverImage,
    this.watchHistory,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    username = json['username'];
    email = json['email'];
    fullname = json['fullname'];
    avatar = json['avatar'];
    coverImage = json['coverImage'];
    watchHistory = json['watchHistory'] ?? [];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonMap = {};
    jsonMap['_id'] = id;
    jsonMap['username'] = username;
    jsonMap['email'] = email;
    jsonMap['fullname'] = fullname;
    jsonMap['avatar'] = avatar;
    jsonMap['coverImage'] = coverImage;
    jsonMap['watchHistory'] = watchHistory;
    jsonMap['createdAt'] = createdAt;
    jsonMap['updatedAt'] = updatedAt;
    jsonMap['__v'] = v;
    return jsonMap;
  }
}
