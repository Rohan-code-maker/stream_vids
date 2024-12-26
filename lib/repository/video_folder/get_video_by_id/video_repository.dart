import 'package:stream_vids/data/network/network_api_services.dart';
import 'package:stream_vids/res/app_url/app_url.dart';

class GetVideoByIdRepository {
  final _apiService = NetworkApiService();

  Future<dynamic> getVideoByIdApi(String videoId) async {
    dynamic response = await _apiService
        .getApi(AppUrl.getVideoByIdUrl + videoId, requiresAuth: true);
    return response;
  }
}
