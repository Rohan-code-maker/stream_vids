import 'package:stream_vids/data/network/network_api_services.dart';
import 'package:stream_vids/res/app_url/app_url.dart';

class AddCommentRepository {
  final _apiService = NetworkApiService();
  Future<dynamic> addCommentRepo(String videoId, var content) async {
    String getUrl(String videoId) {
      return AppUrl.commentUrl.replaceFirst(":videoId", videoId);
    }

    final response =
        await _apiService.postApi(content, getUrl(videoId), requiresAuth: true);
    return response;
  }
}
