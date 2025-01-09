import 'dart:convert';

import 'package:stream_vids/data/network/network_api_services.dart';
import 'package:stream_vids/res/app_url/app_url.dart';

class RefreshTokenRepository {
  final _apiService = NetworkApiService();

  Future<dynamic> refreshTokenApi(String refreshToken) async {
    dynamic response = await _apiService.postApi(jsonEncode({'refreshToken':refreshToken}), AppUrl.refreshTokenUrl);
    return response;
  }
}
