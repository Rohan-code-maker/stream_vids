import 'package:stream_vids/data/network/network_api_services.dart';
import 'package:stream_vids/res/app_url/app_url.dart';

class GetVideoByIdRepository {
  final _apiService = NetworkApiService();

  Future<dynamic> getVideoByIdApi(String videoId) async {
    String getUrl(String videoId) {
      return AppUrl.getVideoByIdUrl.replaceFirst(":videoId", videoId);
    }

    dynamic response =
        await _apiService.getApi(getUrl(videoId), requiresAuth: true);
    return response;
  }
}
