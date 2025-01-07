import 'dart:convert';
import 'package:stream_vids/data/network/network_api_services.dart';
import 'package:stream_vids/res/app_url/app_url.dart';

class SubscribeUserRepository {
  final _apiService = NetworkApiService();
  Future<dynamic> subscribe(String channelId) async {
    String getUrl(String channelId) {
      return AppUrl.subscribeUrl.replaceFirst(":channelId", channelId);
    }

    final response = await _apiService.postApi(jsonEncode({'channelId':channelId}), getUrl(channelId),
        requiresAuth: true);
    return response;
  }
}
