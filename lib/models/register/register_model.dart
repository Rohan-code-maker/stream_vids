class RegisterModel {
  int? statusCode;
  Data? data;
  String? message;
  bool? success;

  RegisterModel({this.statusCode, this.data, this.message, this.success});

  RegisterModel.fromJson(Map<String, dynamic> json) {
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
  String? sId;
  String? username;
  String? email;
  String? fullname;
  String? avatar;
  String? coverImage;
  List<WatchHistoryItem>? watchHistory;
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
      watchHistory = <WatchHistoryItem>[];
      json['watchHistory'].forEach((v) {
        watchHistory!.add(WatchHistoryItem.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonMap = {};
    jsonMap['_id'] = sId;
    jsonMap['username'] = username;
    jsonMap['email'] = email;
    jsonMap['fullname'] = fullname;
    jsonMap['avatar'] = avatar;
    jsonMap['coverImage'] = coverImage;
    if (watchHistory != null) {
      jsonMap['watchHistory'] =
          watchHistory!.map((v) => v.toJson()).toList();
    }
    jsonMap['createdAt'] = createdAt;
    jsonMap['updatedAt'] = updatedAt;
    jsonMap['__v'] = iV;
    return jsonMap;
  }
}

class WatchHistoryItem {
  String? videoId;
  String? watchedAt;

  WatchHistoryItem({this.videoId, this.watchedAt});

  WatchHistoryItem.fromJson(Map<String, dynamic> json) {
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
