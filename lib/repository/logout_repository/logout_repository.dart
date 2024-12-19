import 'dart:convert';

import 'package:stream_vids/data/network/network_api_services.dart';
import 'package:stream_vids/res/app_url/app_url.dart';

class LogoutRepository {
  final _apiService = NetworkApiService();

  Future<dynamic> logoutApi(var data) async {
    dynamic response = await _apiService.postApi(jsonEncode(data), AppUrl.logoutUrl);
    return response;
  }
}
