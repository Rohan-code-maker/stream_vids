import 'package:stream_vids/data/network/network_api_services.dart';
import 'package:stream_vids/res/app_url/app_url.dart';

class LikeCountRepository {
  final _apiService = NetworkApiService();
  Future<dynamic> getLikeCount(String videoId) async {
    String getUrl(String videoId) {
      return AppUrl.likeVideoCountUrl.replaceFirst(":videoId", videoId);
    }

    final reponse =
        await _apiService.getApi(getUrl(videoId), requiresAuth: true);
    return reponse;
  }
}
