import 'package:stream_vids/data/network/network_api_services.dart';
import 'package:stream_vids/res/app_url/app_url.dart';

class GetCommentLikeRepository {
  final _apiService = NetworkApiService();
  Future<dynamic> getCommentLikeRepo(String commentId) async {
    String getUrl(String commentId) {
      return AppUrl.toggleCommentLikeUrl.replaceFirst(":commentId", commentId);
    }

    final response = await _apiService.getApi(getUrl(commentId),requiresAuth: true);
    return response;
  }
}
