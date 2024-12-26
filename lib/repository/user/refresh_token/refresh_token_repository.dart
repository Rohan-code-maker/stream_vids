import 'dart:convert';

import 'package:stream_vids/data/network/network_api_services.dart';
import 'package:stream_vids/res/app_url/app_url.dart';

class RefreshTokenRepository {
  final _apiService = NetworkApiService();

  Future<dynamic> refreshTokenApi(var data) async {
    dynamic reponse = await _apiService.postApi(jsonEncode(data), AppUrl.refreshTokenUrl, requiresAuth: true);
    return reponse;
  }
}
