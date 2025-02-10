import 'package:stream_vids/data/network/network_api_services.dart';
import 'package:stream_vids/res/app_url/app_url.dart';

class GetUserVideosRepository {
  final _apiService = NetworkApiService();

  Future<dynamic> getUserVideos(userId) async {
    String getUrl(userId) {
      return AppUrl.getUserVideos.replaceAll(':userId', userId);
    }
    final response = await _apiService.getApi(getUrl(userId), requiresAuth: true);
    return response;
  }
}
