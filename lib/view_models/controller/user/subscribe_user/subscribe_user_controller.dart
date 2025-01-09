import 'package:get/get.dart';
import 'package:stream_vids/models/user/subscribe_user/subscribe_user_model.dart';
import 'package:stream_vids/repository/user/subscribe_user/subscribe_user_repository.dart';
import 'package:stream_vids/utils/utils.dart';

class SubscribeUserController extends GetxController {
  final _api = SubscribeUserRepository();
  RxBool isSubscribed = false.obs;
  void subscribe(String channelId) async {
    try {
      final response = await _api.subscribe(channelId);
      if (response['statusCode'] == 200) {
        final model = SubsciptionModel.fromJson(response);
        if (model.success!) {
          isSubscribed.value = true;
        } else {
          Utils.snackBar(
              "Error", "Failed to subscribe to channel: ${model.message}");
        }
      } else {
        Utils.snackBar("Error", response['message']);
      }
    } catch (e) {
      final String errorMessage = Utils.extractErrorMessage(e.toString());
      Utils.snackBar("Error", "Error while api call: $errorMessage");
    }
  }
}
