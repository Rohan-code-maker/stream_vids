import 'package:stream_vids/data/network/network_api_services.dart';
import 'package:stream_vids/res/app_url/app_url.dart';

class GetWatchHistoryRepository {
  final _apiService = NetworkApiService();

  Future<dynamic> getWatchHistory() async {
    final response =
        await _apiService.getApi(AppUrl.getWatchHistoryUrl, requiresAuth: true);
    return response;
  }
}
