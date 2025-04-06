class UpdateAccountModel {
  int? statusCode;
  Data? data;
  String? message;
  bool? success;

  UpdateAccountModel({this.statusCode, this.data, this.message, this.success});

  UpdateAccountModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
  List<String>? watchHistory;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? refreshToken;

  Data(
      {this.sId,
      this.username,
      this.email,
      this.fullname,
      this.avatar,
      this.coverImage,
      this.watchHistory,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.refreshToken});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    username = json['username'];
    email = json['email'];
    fullname = json['fullname'];
    avatar = json['avatar'];
    coverImage = json['coverImage'];
    watchHistory = json['watchHistory'].cast<String>();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['username'] = username;
    data['email'] = email;
    data['fullname'] = fullname;
    data['avatar'] = avatar;
    data['coverImage'] = coverImage;
    data['watchHistory'] = watchHistory;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['refreshToken'] = refreshToken;
    return data;
  }
}
