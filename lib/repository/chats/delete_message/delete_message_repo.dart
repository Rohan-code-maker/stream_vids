import 'package:stream_vids/data/network/network_api_services.dart';
import 'package:stream_vids/res/app_url/app_url.dart';

class DeleteMessageRepo {
  final _apiService = NetworkApiService();

  Future<dynamic> deleteMessage(String messageId,String chatId) async {
    String getUrl(String messageId, String chatId) {
      return AppUrl.deleteMessage.replaceFirst(':chatId', chatId).replaceFirst(':messageId', messageId);
    }
    final response = await _apiService.deleteApi(getUrl(messageId, chatId), requiresAuth: true);
    return response;
  }
}