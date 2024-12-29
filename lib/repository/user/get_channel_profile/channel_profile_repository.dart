import 'package:stream_vids/data/network/network_api_services.dart';
import 'package:stream_vids/res/app_url/app_url.dart';

class ChannelProfileRepository {
  final _apiService = NetworkApiService();

  Future<dynamic> getChannelProfile() async {
    final response = await _apiService.getApi(AppUrl.getChannelProfileUrl,requiresAuth: true);
    return response;
  }
}
