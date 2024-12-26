import 'package:stream_vids/data/network/network_api_services.dart';
import 'package:stream_vids/res/app_url/app_url.dart';

class UpdateAvatarRepository {
  final NetworkApiService _apiService = NetworkApiService();

  Future<dynamic> updateAvatarApi(var data){
    final response = _apiService.patchApi(data, AppUrl.updateAvatarUrl,requiresAuth: true);
    return response;
  }
}
