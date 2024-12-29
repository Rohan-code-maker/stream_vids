import 'package:stream_vids/data/network/network_api_services.dart';
import 'package:stream_vids/res/app_url/app_url.dart';

class LoginRepository {
  final _apiService = NetworkApiService();

  Future<dynamic> loginApi(var data) async {
    dynamic reponse = await _apiService.postApi(data, AppUrl.loginUrl);
    return reponse;
  }
}
