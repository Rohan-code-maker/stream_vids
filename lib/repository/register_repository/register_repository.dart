import 'package:stream_vids/data/network/network_api_services.dart';
import 'package:stream_vids/res/app_url/app_url.dart';

class RegisterRepository {
  final _apiService = NetworkApiService();

  Future<dynamic> registerApi(var data) async {
    dynamic response = await _apiService.postApi(data, AppUrl.registerUrl);
    return response;
  }
}
