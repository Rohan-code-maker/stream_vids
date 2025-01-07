class GetVideoLikeStatusModel {
  int? statusCode;
  Data? data;
  String? message;
  bool? success;

  GetVideoLikeStatusModel(
      {this.statusCode, this.data, this.message, this.success});

  GetVideoLikeStatusModel.fromJson(Map<String, dynamic> json) {
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
  bool? isLiked;

  Data({this.isLiked});

  Data.fromJson(Map<String, dynamic> json) {
    isLiked = json['isLiked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isLiked'] = isLiked;
    return data;
  }
}
