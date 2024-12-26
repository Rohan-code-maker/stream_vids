import 'package:stream_vids/data/network/network_api_services.dart';
import 'package:stream_vids/res/app_url/app_url.dart';

class UpdateAccountRepository {
  final NetworkApiService _apiService = NetworkApiService();

  Future<dynamic> updateAccountApi(var data){
    final response = _apiService.patchApi(data, AppUrl.updateAccountUrl,requiresAuth: true);
    return response;
  }
}
