class GetLikedVideoModel {
  int? statusCode;
  List<Data>? data;
  String? message;
  bool? success;

  GetLikedVideoModel({this.statusCode, this.data, this.message, this.success});

  GetLikedVideoModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    data['success'] = success;
    return data;
  }
}

class Data {
  String? videoId;
  String? title;
  String? description;
  String? thumbnail;
  String? videoFile;
  double? duration;
  Owner? owner;

  Data(
      {this.videoId,
      this.title,
      this.description,
      this.thumbnail,
      this.videoFile,
      this.duration,
      this.owner});

  Data.fromJson(Map<String, dynamic> json) {
    videoId = json['videoId'];
    title = json['title'];
    description = json['description'];
    thumbnail = json['thumbnail'];
    videoFile = json['videoFile'];
    duration = json['duration'];
    owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['videoId'] = videoId;
    data['title'] = title;
    data['description'] = description;
    data['thumbnail'] = thumbnail;
    data['videoFile'] = videoFile;
    data['duration'] = duration;
    if (owner != null) {
      data['owner'] = owner!.toJson();
    }
    return data;
  }
}

class Owner {
  String? sId;
  String? username;
  String? fullname;
  String? avatar;

  Owner({this.sId, this.username, this.fullname, this.avatar});

  Owner.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    username = json['username'];
    fullname = json['fullname'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['username'] = username;
    data['fullname'] = fullname;
    data['avatar'] = avatar;
    return data;
  }
}
