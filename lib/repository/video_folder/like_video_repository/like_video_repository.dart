import 'dart:convert';

import 'package:stream_vids/data/network/network_api_services.dart';
import 'package:stream_vids/res/app_url/app_url.dart';

class LikeVideoRepository {
  final _apiService = NetworkApiService();
  Future<dynamic> likeVideoRepo(String videoId) async {
    String getUrl(String videoId) {
      return AppUrl.likeVideoUrl.replaceFirst(":videoId", videoId);
    }
    final response = await _apiService
        .postApi(jsonEncode({'videoId':videoId}), getUrl(videoId), requiresAuth: true);
    return response;
  }
}
