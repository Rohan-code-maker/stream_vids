import 'package:stream_vids/data/network/network_api_services.dart';
import 'package:stream_vids/res/app_url/app_url.dart';

class GetVideoLikeStatusRepository {
  final _apiService = NetworkApiService();

  Future<dynamic> getLikeStatus(String videoId) async {
    String geturl(String videoId) {
      return AppUrl.likeVideoUrl.replaceFirst(":videoId",videoId);
    }

    final response = await _apiService.getApi(geturl(videoId),requiresAuth: true);
    return response;
  }
}
