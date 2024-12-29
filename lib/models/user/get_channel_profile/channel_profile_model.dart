class ChannelProfileModel {
  int? statusCode;
  Data? data;
  String? message;
  bool? success;

  ChannelProfileModel({this.statusCode, this.data, this.message, this.success});

  ChannelProfileModel.fromJson(Map<String, dynamic> json) {
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
  String? username;
  String? email;
  String? fullname;
  String? avatar;
  String? coverImage;
  int? subscribersCount;
  int? channelsSubscribedToCount;
  bool? isSubscribed;

  Data(
      {this.sId,
      this.username,
      this.email,
      this.fullname,
      this.avatar,
      this.coverImage,
      this.subscribersCount,
      this.channelsSubscribedToCount,
      this.isSubscribed});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    username = json['username'];
    email = json['email'];
    fullname = json['fullname'];
    avatar = json['avatar'];
    coverImage = json['coverImage'];
    subscribersCount = json['subscribersCount'];
    channelsSubscribedToCount = json['channelsSubscribedToCount'];
    isSubscribed = json['isSubscribed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['username'] = username;
    data['email'] = email;
    data['fullname'] = fullname;
    data['avatar'] = avatar;
    data['coverImage'] = coverImage;
    data['subscribersCount'] = subscribersCount;
    data['channelsSubscribedToCount'] = channelsSubscribedToCount;
    data['isSubscribed'] = isSubscribed;
    return data;
  }
}
