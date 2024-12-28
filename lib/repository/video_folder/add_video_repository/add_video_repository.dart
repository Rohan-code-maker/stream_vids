import 'package:stream_vids/data/network/network_api_services.dart';
import 'package:stream_vids/res/app_url/app_url.dart';

class AddVideoRepository {
  final _apiService = NetworkApiService();

  Future<dynamic> addVideo(var data) async {
    final response =
        await _apiService.postApi(data, AppUrl.addVideoUrl, requiresAuth: true);
    return response;
  }
}
