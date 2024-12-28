import 'package:flutter/foundation.dart';
import 'package:stream_vids/data/network/network_api_services.dart';
import 'package:stream_vids/res/app_url/app_url.dart';

class AddWatchHistoryRepository {
  final apiService = NetworkApiService();

  Future<dynamic> addWatchHistory(var data) async{
    final response = await apiService.patchApi(AppUrl.addWatchHistoryUrl,data,requiresAuth: true);
    if (kDebugMode) {
        print("Repository:$response");
      }
    return response;
  }
}
