import 'package:stream_vids/data/network/network_api_services.dart';
import 'package:stream_vids/res/app_url/app_url.dart';

class DeleteChatRepo {
  final _apiService = NetworkApiService();

  Future<dynamic> deleteChat(String chatId) async {
    String getUrl(String chatId) {
      return AppUrl.deleteChat.replaceFirst(':chatId', chatId);
    }

    final response =
        await _apiService.deleteApi(getUrl(chatId), requiresAuth: true);
    return response;
  }
}
