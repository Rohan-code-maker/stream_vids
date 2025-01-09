class ViewCommentModel {
  int? statusCode;
  Data? data;
  String? message;
  bool? success;

  ViewCommentModel({this.statusCode, this.data, this.message, this.success});

  ViewCommentModel.fromJson(Map<String, dynamic> json) {
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
  List<Comments>? comments;

  Data({this.comments});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(Comments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (comments != null) {
      data['comments'] = comments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Comments {
  String? sId;
  String? content;
  CommentedBy? commentedBy;

  Comments({this.sId, this.content, this.commentedBy});

  Comments.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    content = json['content'];
    commentedBy = json['commentedBy'] != null
        ? CommentedBy.fromJson(json['commentedBy'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['content'] = content;
    if (commentedBy != null) {
      data['commentedBy'] = commentedBy!.toJson();
    }
    return data;
  }
}

class CommentedBy {
  String? sId;
  String? username;
  String? fullname;
  String? avatar;

  CommentedBy({this.sId, this.username, this.fullname, this.avatar});

  CommentedBy.fromJson(Map<String, dynamic> json) {
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
