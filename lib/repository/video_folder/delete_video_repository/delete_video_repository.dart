import 'package:stream_vids/data/network/network_api_services.dart';
import 'package:stream_vids/res/app_url/app_url.dart';

class DeleteVideoRepository {
  final _apiService = NetworkApiService();
  String getUrl(String url) {
    return AppUrl.updateVideoUrl.replaceFirst(":videoId", url);
  }

  Future<dynamic> deleteVideo(String url) {
    final response = _apiService.deleteApi(getUrl(url),requiresAuth: true);
    return response;
  }
}
