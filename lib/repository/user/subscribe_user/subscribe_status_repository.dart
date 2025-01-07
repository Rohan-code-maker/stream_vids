import 'package:stream_vids/data/network/network_api_services.dart';
import 'package:stream_vids/res/app_url/app_url.dart';

class SubscribeStatusRepository {
  final _apiService = NetworkApiService();
  Future<dynamic> subscribeStatus(String channelId) async {
    String getUrl(String channelId) {
      return AppUrl.subscribeUrl.replaceFirst(":channelId", channelId);
    }

    final response = await _apiService.getApi(getUrl(channelId),requiresAuth: true);
    return response;
  }
}
