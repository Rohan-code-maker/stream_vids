import 'package:stream_vids/data/network/network_api_services.dart';
import 'package:stream_vids/res/app_url/app_url.dart';

class GetAllMessagesRepo {
  final _apiService = NetworkApiService();

  Future<dynamic> getAllMessages(String chatId) async {
    String getUrl(String chatId) {
      return AppUrl.getAllMessages.replaceFirst(':chatId', chatId);
    }

    final response = await _apiService.getApi(getUrl(chatId), requiresAuth: true);
    return response;
  }
}
