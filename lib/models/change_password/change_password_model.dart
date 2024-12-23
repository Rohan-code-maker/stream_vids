class ChangePasswordModel {
  int? statusCode;
  String? message;
  bool? success;

  ChangePasswordModel({this.statusCode, this.message, this.success});

  ChangePasswordModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonMap = {};
    jsonMap['statusCode'] = statusCode;
    jsonMap['message'] = message;
    jsonMap['success'] = success;
    return jsonMap;
  }
}
