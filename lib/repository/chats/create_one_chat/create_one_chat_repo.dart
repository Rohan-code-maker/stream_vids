import 'dart:convert';

import 'package:stream_vids/data/network/network_api_services.dart';
import 'package:stream_vids/res/app_url/app_url.dart';

class CreateOneChatRepo {
  final _apiService = NetworkApiService();

  Future<dynamic> createOneChat(String recieverId) async{
    String getUrl(String recieverId) {
      return AppUrl.createOneChat.replaceFirst(":recieverId", recieverId);
    }
    final response = await _apiService.postApi(jsonEncode({'recieverId':recieverId}), getUrl(recieverId),requiresAuth: true);
    return response;
  }
}