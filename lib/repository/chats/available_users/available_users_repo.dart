import 'package:stream_vids/data/network/network_api_services.dart';
import 'package:stream_vids/res/app_url/app_url.dart';

class AvailableUsersRepo {
  final _apiservice = NetworkApiService();

  Future<dynamic> getAvailableUsers() async {
    dynamic response = await _apiservice.getApi(AppUrl.getAvailableUsers, requiresAuth: true);
    return response;
  }
}