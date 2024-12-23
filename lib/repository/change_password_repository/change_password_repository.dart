import 'package:stream_vids/data/network/network_api_services.dart';
import 'package:stream_vids/res/app_url/app_url.dart';

class ChangePasswordRepository {
  final _apiService = NetworkApiService();

  Future<dynamic> changePasswordApi(var data) async {
    dynamic reponse = await _apiService.postApi(data, AppUrl.forgotPasswordUrl,requiresAuth: true);
    return reponse;
  }
}
