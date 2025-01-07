class LikeCountModel {
  int? statusCode;
  Data? data;
  String? message;
  bool? success;

  LikeCountModel({this.statusCode, this.data, this.message, this.success});

  LikeCountModel.fromJson(Map<String, dynamic> json) {
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
  int? likeCount;

  Data({this.likeCount});

  Data.fromJson(Map<String, dynamic> json) {
    likeCount = json['likeCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['likeCount'] = likeCount;
    return data;
  }
}
