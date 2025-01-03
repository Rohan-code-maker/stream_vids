class UpdateAvatarModel {
  int? statusCode;
  Data? data;
  String? message;
  bool? success;

  UpdateAvatarModel({this.statusCode, this.data, this.message, this.success});

  UpdateAvatarModel.fromJson(Map<String, dynamic> json) {
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
  List<WatchHistory>? watchHistory;
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['username'] = username;
    data['email'] = email;
    data['fullname'] = fullname;
    data['avatar'] = avatar;
    data['coverImage'] = coverImage;
    if (watchHistory != null) {
      data['watchHistory'] = watchHistory!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
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

