import 'package:stream_vids/data/network/network_api_services.dart';
import 'package:stream_vids/res/app_url/app_url.dart';

class SendMessageRepo {
  final _apiService = NetworkApiService();

  Future<dynamic> sendMessage(var content, String url) async {
    String getUrl(String url) {
      return AppUrl.getAllMessages.replaceFirst(':chatId', url);
    }

    final response =
        await _apiService.postApi(content, getUrl(url), requiresAuth: true);
    return response;
  }
}
