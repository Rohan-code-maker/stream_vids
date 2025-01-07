class SubsciptionStatusModel {
  int? statusCode;
  Data? data;
  String? message;
  bool? success;

  SubsciptionStatusModel(
      {this.statusCode, this.data, this.message, this.success});

  SubsciptionStatusModel.fromJson(Map<String, dynamic> json) {
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
  bool? isSubscribed;

  Data({this.isSubscribed});

  Data.fromJson(Map<String, dynamic> json) {
    isSubscribed = json['isSubscribed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isSubscribed'] = isSubscribed;
    return data;
  }
}
