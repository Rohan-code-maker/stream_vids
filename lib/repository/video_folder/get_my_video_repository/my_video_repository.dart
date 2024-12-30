import 'package:stream_vids/data/network/network_api_services.dart';
import 'package:stream_vids/res/app_url/app_url.dart';

class MyVideoRepository {
  final _apiService = NetworkApiService();
  Future<dynamic> getMyVideo() async{
    final response = await _apiService.getApi(AppUrl.getMyVideoUrl,requiresAuth: true);
    return response;
  }
}
