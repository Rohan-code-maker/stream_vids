class UserVideosModel {
  int? statusCode;
  Data? data;
  String? message;
  bool? success;

  UserVideosModel({this.statusCode, this.data, this.message, this.success});

  UserVideosModel.fromJson(Map<String, dynamic> json) {
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
  List<UserVideos>? userVideos;

  Data({this.userVideos});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['userVideos'] != null) {
      userVideos = <UserVideos>[];
      json['userVideos'].forEach((v) {
        userVideos!.add(UserVideos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (userVideos != null) {
      data['userVideos'] = userVideos!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserVideos {
  String? sId;
  String? videoFile;
  String? thumbnail;
  String? title;
  String? description;
  CreatedBy? createdBy;

  UserVideos(
      {this.sId,
      this.videoFile,
      this.thumbnail,
      this.title,
      this.description,
      this.createdBy});

  UserVideos.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    videoFile = json['videoFile'];
    thumbnail = json['thumbnail'];
    title = json['title'];
    description = json['description'];
    createdBy = json['createdBy'] != null
        ? CreatedBy.fromJson(json['createdBy'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['videoFile'] = videoFile;
    data['thumbnail'] = thumbnail;
    data['title'] = title;
    data['description'] = description;
    if (createdBy != null) {
      data['createdBy'] = createdBy!.toJson();
    }
    return data;
  }
}

class CreatedBy {
  String? username;
  String? fullname;
  String? avatar;

  CreatedBy({this.username, this.fullname, this.avatar});

  CreatedBy.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    fullname = json['fullname'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['fullname'] = fullname;
    data['avatar'] = avatar;
    return data;
  }
}
