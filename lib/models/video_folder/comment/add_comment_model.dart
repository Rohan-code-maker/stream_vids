class AddCommentModel {
  int? statusCode;
  Data? data;
  String? message;
  bool? success;

  AddCommentModel({this.statusCode, this.data, this.message, this.success});

  AddCommentModel.fromJson(Map<String, dynamic> json) {
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
  Comment? comment;

  Data({this.comment});

  Data.fromJson(Map<String, dynamic> json) {
    comment =
        json['comment'] != null ? Comment.fromJson(json['comment']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (comment != null) {
      data['comment'] = comment!.toJson();
    }
    return data;
  }
}

class Comment {
  String? content;
  String? video;
  String? owner;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Comment(
      {this.content,
      this.video,
      this.owner,
      this.sId,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Comment.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    video = json['video'];
    owner = json['owner'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['content'] = content;
    data['video'] = video;
    data['owner'] = owner;
    data['_id'] = sId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
