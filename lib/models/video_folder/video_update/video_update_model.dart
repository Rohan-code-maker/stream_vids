class VideoUpdateModel {
  int? statusCode;
  Data? data;
  String? message;
  bool? success;

  VideoUpdateModel({this.statusCode, this.data, this.message, this.success});

  VideoUpdateModel.fromJson(Map<String, dynamic> json) {
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
  UpdatedVideo? updatedVideo;

  Data({this.updatedVideo});

  Data.fromJson(Map<String, dynamic> json) {
    updatedVideo = json['updatedVideo'] != null
        ? UpdatedVideo.fromJson(json['updatedVideo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (updatedVideo != null) {
      data['updatedVideo'] = updatedVideo!.toJson();
    }
    return data;
  }
}

class UpdatedVideo {
  String? sId;
  String? videoFile;
  String? thumbnail;
  String? title;
  String? description;
  double? duration;
  int? views;
  bool? isPublished;
  String? owner;
  String? createdAt;
  String? updatedAt;
  int? iV;

  UpdatedVideo(
      {this.sId,
      this.videoFile,
      this.thumbnail,
      this.title,
      this.description,
      this.duration,
      this.views,
      this.isPublished,
      this.owner,
      this.createdAt,
      this.updatedAt,
      this.iV});

  UpdatedVideo.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    videoFile = json['videoFile'];
    thumbnail = json['thumbnail'];
    title = json['title'];
    description = json['description'];
    duration = json['duration'];
    views = json['views'];
    isPublished = json['isPublished'];
    owner = json['owner'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['videoFile'] = videoFile;
    data['thumbnail'] = thumbnail;
    data['title'] = title;
    data['description'] = description;
    data['duration'] = duration;
    data['views'] = views;
    data['isPublished'] = isPublished;
    data['owner'] = owner;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
