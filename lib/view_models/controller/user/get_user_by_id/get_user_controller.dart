import 'package:get/get.dart';
import 'package:stream_vids/repository/user/get_user_by_id/get_user_repository.dart';
import 'package:stream_vids/models/user/get_channel_profile/channel_profile_model.dart';
import 'package:stream_vids/utils/utils.dart';

class GetUserController extends GetxController {
  final _api = GetUserRepository();
  var isLoading = true.obs;
  var channelProfile = ChannelProfileModel().obs;

  void getUserById(userId) async {
    isLoading(true);
    try {
      final response = await _api.getUserById(userId);
      if (response['statusCode'] == 200) {
        final channelProfileModel = ChannelProfileModel.fromJson(response);
        if (channelProfileModel.success!) {
          channelProfile.value = channelProfileModel;
        } else {
          Utils.snackBar("error".tr, channelProfileModel.message!);
        }
      } else {
        Utils.snackBar("error".tr, response['message']);
      }
    } catch (e) {
      final String err = Utils.extractErrorMessage(e.toString());
      Utils.snackBar("error".tr, err);
    } finally {
      isLoading(false);
    }
  }

  
}
