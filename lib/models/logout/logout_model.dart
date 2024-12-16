class LogoutModel {
  int? statusCode;
  String? message;
  bool? success;

  LogoutModel({this.statusCode, this.message, this.success});

  LogoutModel.fromJson(Map<String, dynamic> json) {
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
