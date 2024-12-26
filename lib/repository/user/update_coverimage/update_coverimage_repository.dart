import 'package:stream_vids/data/network/network_api_services.dart';
import 'package:stream_vids/res/app_url/app_url.dart';

class UpdateCoverImageRepository {
  final NetworkApiService _apiService = NetworkApiService();

  Future<dynamic> updateCoverImageApi(String data){
    final response = _apiService.patchApi(data, AppUrl.updateCoverImageUrl,requiresAuth: true);
    return response;
  }
}
