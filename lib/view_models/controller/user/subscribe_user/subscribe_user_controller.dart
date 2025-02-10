import 'package:get/get.dart';
import 'package:stream_vids/models/user/subscribe_user/subscribe_status_model.dart';
import 'package:stream_vids/models/user/subscribe_user/subscribe_user_model.dart';
import 'package:stream_vids/repository/user/subscribe_user/subscribe_status_repository.dart';
import 'package:stream_vids/repository/user/subscribe_user/subscribe_user_repository.dart';
import 'package:stream_vids/utils/utils.dart';

class SubscribeUserController extends GetxController {
  final _api = SubscribeUserRepository();
  RxBool isSubscribed = false.obs;
  final _api2 = SubscribeStatusRepository();

  void subscribe(String channelId) async {
    try {
      final response = await _api.subscribe(channelId);
      if (response['statusCode'] == 200) {
        final model = SubsciptionModel.fromJson(response);
        if (model.success!) {
          getSubscribedStatus(channelId);
        } else {
          Utils.snackBar(
              "Error", "Failed to subscribe to channel: ${model.message}");
        }
      } else {
        Utils.snackBar("Error", response['message']);
      }
    } catch (e) {
      final String errorMessage = Utils.extractErrorMessage(e.toString());
      Utils.snackBar("Error", errorMessage);
    }
  }

  void getSubscribedStatus(String channelId) async {
    try {
      final response = await _api2.subscribeStatus(channelId);
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
      final String err = Utils.extractErrorMessage(e.toString());
      Utils.snackBar("Error", err);
    }
  }
}
