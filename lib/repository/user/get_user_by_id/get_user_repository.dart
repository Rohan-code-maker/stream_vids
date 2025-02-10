import 'package:stream_vids/data/network/network_api_services.dart';
import 'package:stream_vids/res/app_url/app_url.dart';

class GetUserRepository {
  final _apiService = NetworkApiService();

  Future<dynamic> getUserById(userId) async {
    String getUrl(userId) {
      return AppUrl.getUser.replaceAll(':userId', userId);
    }

    final response =
        await _apiService.getApi(getUrl(userId), requiresAuth: true);
    return response;
  }
}
