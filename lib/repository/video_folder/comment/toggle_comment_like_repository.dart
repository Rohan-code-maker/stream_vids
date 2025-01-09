import 'dart:convert';

import 'package:stream_vids/data/network/network_api_services.dart';
import 'package:stream_vids/res/app_url/app_url.dart';

class ToggleCommentLikeRepository {
  final _apiService = NetworkApiService();
  Future<dynamic> toggleCommentLikeRepo(String commentId) async {
    String getUrl(String commentId) {
      return AppUrl.toggleCommentLikeUrl.replaceFirst(":commentId", commentId);
    }

    final response = await _apiService.postApi(jsonEncode({'commentId':commentId}), getUrl(commentId),requiresAuth: true);
    return response;
  }
}
