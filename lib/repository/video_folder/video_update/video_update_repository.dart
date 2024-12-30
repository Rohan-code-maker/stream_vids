import 'package:stream_vids/data/network/network_api_services.dart';
import 'package:stream_vids/res/app_url/app_url.dart';

class VideoUpdateRepository {
  final _apiService = NetworkApiService();

  Future<dynamic> updateVideo(var data, String videoId) async {
    String getUrl(String videoId) {
      return AppUrl.updateVideoUrl.replaceFirst(":videoId", videoId);
    }

    final response =
        await _apiService.patchApi(data, getUrl(videoId), requiresAuth: true);
    return response;
  }
}
