class GetAllChatsModel {
  int? statusCode;
  List<Data>? data;
  String? message;
  bool? success;

  GetAllChatsModel({this.statusCode, this.data, this.message, this.success});

  GetAllChatsModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  bool? isGroupChat;
  List<Participants>? participants;
  String? admin;
  String? createdAt;
  String? updatedAt;
  int? iV;
  LastMessage? lastMessage;

  Data(
      {this.sId,
      this.name,
      this.isGroupChat,
      this.participants,
      this.admin,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.lastMessage});

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
    lastMessage = json['lastMessage'] != null
        ? LastMessage.fromJson(json['lastMessage'])
        : null;
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
    if (lastMessage != null) {
      data['lastMessage'] = lastMessage!.toJson();
    }
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
    watchHistory = json['watchHistory']?.cast<String>();
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

class LastMessage {
  String? sId;
  Sender? sender;
  String? content;
  List<dynamic>? attachments; // Fixed attachments type
  String? chat;
  String? createdAt;
  String? updatedAt;
  int? iV;

  LastMessage(
      {this.sId,
      this.sender,
      this.content,
      this.attachments,
      this.chat,
      this.createdAt,
      this.updatedAt,
      this.iV});

  LastMessage.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    sender = json['sender'] != null ? Sender.fromJson(json['sender']) : null;
    content = json['content'];
    attachments = json['attachments'] ?? [];
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
    data['attachments'] = attachments;
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
