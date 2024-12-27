class RegisterModel {
  int? statusCode;
  Data? data;
  String? message;
  bool? success;

  RegisterModel({this.statusCode, this.data, this.message, this.success});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'] ?? 0; // Default to 0 if missing
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'] ?? 'No message provided'; // Default message
    success = json['success'] ?? false; // Default to false
  }

  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'data': data?.toJson(),
      'message': message,
      'success': success,
    };
  }
}

class Data {
  String? sId;
  String? username;
  String? email;
  String? fullname;
  String? avatar;
  String? coverImage;
  List<String>? watchHistory = [];
  String? createdAt;
  String? updatedAt;
  int? iV;

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
    this.iV,
  });

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    username = json['username'] ?? 'Unknown';
    email = json['email'] ?? '';
    fullname = json['fullname'] ?? '';
    avatar = json['avatar'] ?? '';
    coverImage = json['coverImage'] ?? '';
    watchHistory = json['watchHistory'] != null
        ? List<String>.from(json['watchHistory'])
        : [];
    createdAt = json['createdAt'] ?? '';
    updatedAt = json['updatedAt'] ?? '';
    iV = json['__v'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': sId,
      'username': username,
      'email': email,
      'fullname': fullname,
      'avatar': avatar,
      'coverImage': coverImage,
      'watchHistory': watchHistory,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': iV,
    };
  }
}
