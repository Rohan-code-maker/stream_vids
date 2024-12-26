import 'package:stream_vids/data/network/network_api_services.dart';
import 'package:stream_vids/res/app_url/app_url.dart';

class GetAllVideoRepository{
  final _apiService = NetworkApiService();

  Future<dynamic> getAllVideoApi({String query = ""}) async {
    dynamic reponse = await _apiService.getApi(AppUrl.getAllVideoUrl+query,requiresAuth: true);
    return reponse;
  }
}