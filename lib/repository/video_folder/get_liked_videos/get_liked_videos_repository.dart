import 'package:stream_vids/data/network/network_api_services.dart';
import 'package:stream_vids/res/app_url/app_url.dart';

class GetLikedVideosRepository {
  final _apiService = NetworkApiService();
  Future<dynamic> getLikedVideos() async {
    final response = await _apiService.getApi(AppUrl.getlikeVideoUrl,requiresAuth: true);
    return response;
  }
}
