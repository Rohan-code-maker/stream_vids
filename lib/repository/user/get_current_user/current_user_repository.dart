import 'package:stream_vids/data/network/network_api_services.dart';
import 'package:stream_vids/res/app_url/app_url.dart';

class CurrentUserRepository {
  final _apiService = NetworkApiService();

  Future<dynamic> currentUserApi() async {
    dynamic reponse = await _apiService.getApi(AppUrl.getCurrentUserUrl,requiresAuth: true);
    return reponse;
  }
}
