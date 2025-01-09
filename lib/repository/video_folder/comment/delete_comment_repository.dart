import 'package:stream_vids/data/network/network_api_services.dart';
import 'package:stream_vids/res/app_url/app_url.dart';

class DeleteCommentRepository {
  final _apiService = NetworkApiService();

  Future<dynamic> deleteComment(String commentId) async {
    String getUrl(String commentId) {
      return AppUrl.updateCommentUrl.replaceFirst(":commentId", commentId);
    }

    final response =
        await _apiService.deleteApi(getUrl(commentId), requiresAuth: true);
    return response;
  }
}
