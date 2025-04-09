class GetAllMessageModel {
  int? statusCode;
  List<Data>? data;
  String? message;
  bool? success;

  GetAllMessageModel({this.statusCode, this.data, this.message, this.success});

  GetAllMessageModel.fromJson(Map<String, dynamic> json) {
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
  String? sId;
  Sender? sender;
  String? content;
  List<dynamic>? attachments;
  String? chat;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.sId,
      this.sender,
      this.content,
      this.attachments,
      this.chat,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    sender =
        json['sender'] != null ? Sender.fromJson(json['sender']) : null;
    content = json['content'];
    if (json['attachments'] != null) {
      attachments = List<dynamic>.from(json['attachments']);
    }
    chat = json['chat'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (sender != null) {
      data['sender'] = sender!.toJson();
    }
    data['content'] = content;
    if (attachments != null) {
      data['attachments'] = attachments!.map((v) => v.toJson()).toList();
    }
    data['chat'] = chat;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class Sender {
  String? sId;
  String? username;
  String? email;
  String? avatar;

  Sender({this.sId, this.username, this.email, this.avatar});

  Sender.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    username = json['username'];
    email = json['email'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['username'] = username;
    data['email'] = email;
    data['avatar'] = avatar;
    return data;
  }
}
