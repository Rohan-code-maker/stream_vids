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
    final Map<String, dynamic> dataMap = <String, dynamic>{};
    dataMap['statusCode'] = statusCode;
    if (data != null) {
      dataMap['data'] = data!.toJson();
    }
    dataMap['message'] = message;
    dataMap['success'] = success;
    return dataMap;
  }
}

class Data {
  String? sId;
  String? username;
  String? email;
  String? fullname;
  String? avatar;
  String? coverImage;
  List<WatchHistory>? watchHistory;
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
    if (json['watchHistory'] != null) {
      watchHistory = <WatchHistory>[];
      json['watchHistory'].forEach((v) {
        watchHistory!.add(WatchHistory.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = <String, dynamic>{};
    dataMap['_id'] = sId;
    dataMap['username'] = username;
    dataMap['email'] = email;
    dataMap['fullname'] = fullname;
    dataMap['avatar'] = avatar;
    dataMap['coverImage'] = coverImage;
    if (watchHistory != null) {
      dataMap['watchHistory'] = watchHistory!.map((v) => v.toJson()).toList();
    }
    dataMap['createdAt'] = createdAt;
    dataMap['updatedAt'] = updatedAt;
    dataMap['__v'] = iV;
    dataMap['refreshToken'] = refreshToken;
    return dataMap;
  }
}

class WatchHistory {
  String? videoId;
  String? watchedAt;

  WatchHistory({this.videoId, this.watchedAt});

  WatchHistory.fromJson(Map<String, dynamic> json) {
    videoId = json['videoId'];
    watchedAt = json['watchedAt'];
  }

  Map<String, dynamic> toJson() {
    return {
      'videoId': videoId,
      'watchedAt': watchedAt,
    };
  }
}
