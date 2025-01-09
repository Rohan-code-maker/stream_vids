import 'package:stream_vids/data/network/network_api_services.dart';
import 'package:stream_vids/res/app_url/app_url.dart';

class UpdateCommentRepository {
  final _apiService = NetworkApiService();

  Future<dynamic> updateComment(String commentId, var content) async {
    String getUrl(String commentId) {
      return AppUrl.updateCommentUrl.replaceFirst(":commentId", commentId);
    }

    final response = await _apiService.patchApi(content, getUrl(commentId),requiresAuth: true);
    return response;
  }
}
