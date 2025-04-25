import 'package:stream_vids/data/network/network_api_services.dart';
import 'package:stream_vids/res/app_url/app_url.dart';

class GetAllVideoRepository{
  final _apiService = NetworkApiService();

  Future<dynamic> getAllVideoApi({int page = 1,String query = ""}) async {
    dynamic reponse = await _apiService.getApi(AppUrl.getAllVideoUrl(page: page,query: query),requiresAuth: true);
    return reponse;
  }
}