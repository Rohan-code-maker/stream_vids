class DeleteMessageModel {
  int? statusCode;
  Data? data;
  String? message;
  bool? success;

  DeleteMessageModel({this.statusCode, this.data, this.message, this.success});

  DeleteMessageModel.fromJson(Map<String, dynamic> json) {
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
  String? sender;
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
    sender = json['sender'];
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
    data['sender'] = sender;
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
