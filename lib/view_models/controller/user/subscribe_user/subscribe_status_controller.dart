import 'package:get/get.dart';
import 'package:stream_vids/models/user/subscribe_user/subscribe_status_model.dart';
import 'package:stream_vids/repository/user/subscribe_user/subscribe_status_repository.dart';
import 'package:stream_vids/utils/utils.dart';

class SubscribeStatusController extends GetxController {
  final _api = SubscribeStatusRepository();
  RxBool isSubscribed = false.obs;

  void getSubscribedStatus(String channelId) async {
    try {
      final response = await _api.subscribeStatus(channelId);
      if (response['statusCode'] == 200) {
        final model = SubsciptionStatusModel.fromJson(response);
        if (model.success!) {
          if (model.data!.isSubscribed!) {
            isSubscribed.value = true;
          } else {
            isSubscribed.value = false;
          }
        } else {
          Utils.snackBar("Error", model.message!);
        }
      } else {
        Utils.snackBar(
            "Error", "Error during api call: ${response['message']}");
      }
    } catch (e) {
      Utils.snackBar("Error", "Error while fetching api:$e");
    }
  }
}
