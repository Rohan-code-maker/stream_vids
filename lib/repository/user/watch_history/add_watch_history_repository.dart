import 'package:stream_vids/data/network/network_api_services.dart';
import 'package:stream_vids/res/app_url/app_url.dart';

class AddWatchHistoryRepository {
  final apiService = NetworkApiService();

  Future<dynamic> addWatchHistory(var data) async {
    String getUrl(String videoId) {
      return AppUrl.addWatchHistoryUrl
          .replaceFirst(":videoId", videoId);
    }
    final url = getUrl(data);
    final response = await apiService
        .patchApi({}, url, requiresAuth: true);
    return response;
  }
}
