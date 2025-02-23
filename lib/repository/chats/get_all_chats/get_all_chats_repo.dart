import 'package:stream_vids/data/network/network_api_services.dart';
import 'package:stream_vids/res/app_url/app_url.dart';

class GetAllChatsRepo{
  final _apiservice = NetworkApiService();

  Future<dynamic> getAllChats() async{
    dynamic response = await _apiservice.getApi(AppUrl.getAllChats,requiresAuth: true);
    return response;
  }
}