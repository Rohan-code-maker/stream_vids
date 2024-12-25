class CurrentUserModel {
  int? statusCode;
  Data? data;
  String? message;
  bool? success;

  CurrentUserModel({this.statusCode, this.data, this.message, this.success});

  CurrentUserModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['statusCode'] = statusCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    data['success'] = success;
    return data;
  }
}

class Data {
  String? sId;
  String? username;
  String? email;
  String? fullname;
  String? avatar;
  String? coverImage;
  List<dynamic>? watchHistory;
  DateTime? createdAt; // Change to DateTime
  DateTime? updatedAt; // Change to DateTime
  int? v;

  Data({
    this.sId,
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

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    username = json['username'];
    email = json['email'];
    fullname = json['fullname'];
    avatar = json['avatar'];
    coverImage = json['coverImage'];
    if (json['watchHistory'] != null) {
      watchHistory = List<dynamic>.from(json['watchHistory']);
    }
    createdAt = DateTime.parse(json['createdAt']);
    updatedAt = DateTime.parse(json['updatedAt']);
    v = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = sId;
    data['username'] = username;
    data['email'] = email;
    data['fullname'] = fullname;
    data['avatar'] = avatar;
    data['coverImage'] = coverImage;
    if (watchHistory != null) {
      data['watchHistory'] = watchHistory;
    }
    data['createdAt'] = createdAt?.toIso8601String();
    data['updatedAt'] = updatedAt?.toIso8601String();
    data['__v'] = v;
    return data;
  }
}
