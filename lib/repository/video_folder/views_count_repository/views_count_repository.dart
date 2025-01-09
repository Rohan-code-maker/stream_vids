import 'package:stream_vids/data/network/network_api_services.dart';
import 'package:stream_vids/res/app_url/app_url.dart';

class ViewsCountRepository {
  final _apiService = NetworkApiService();
  Future<dynamic> getViewsCount(String videoId) async {
    String getUrl(String videoId) {
      return AppUrl.viewsCountUrl.replaceFirst(":videoId", videoId);
    }

    final response =
        await _apiService.getApi(getUrl(videoId), requiresAuth: true);
    return response;
  }
}
