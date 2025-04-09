class CreateOneOnOneChatModel {
  int? statusCode;
  Data? data;
  String? message;
  bool? success;

  CreateOneOnOneChatModel(
      {this.statusCode, this.data, this.message, this.success});

  CreateOneOnOneChatModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  bool? isGroupChat;
  List<Participants>? participants;
  String? admin;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.sId,
      this.name,
      this.isGroupChat,
      this.participants,
      this.admin,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    isGroupChat = json['isGroupChat'];
    if (json['participants'] != null) {
      participants = <Participants>[];
      json['participants'].forEach((v) {
        participants!.add(Participants.fromJson(v));
      });
    }
    admin = json['admin'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['isGroupChat'] = isGroupChat;
    if (participants != null) {
      data['participants'] = participants!.map((v) => v.toJson()).toList();
    }
    data['admin'] = admin;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class Participants {
  String? sId;
  String? username;
  String? email;
  String? fullname;
  String? avatar;
  String? coverImage;
  List<String>? watchHistory;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Participants(
      {this.sId,
      this.username,
      this.email,
      this.fullname,
      this.avatar,
      this.coverImage,
      this.watchHistory,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Participants.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    username = json['username'];
    email = json['email'];
    fullname = json['fullname'];
    avatar = json['avatar'];
    coverImage = json['coverImage'];
    watchHistory = json['watchHistory'].cast<String>();
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
    data['watchHistory'] = watchHistory;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
