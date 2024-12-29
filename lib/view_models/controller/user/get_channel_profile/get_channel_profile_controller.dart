import 'package:get/get.dart';
import 'package:stream_vids/models/user/get_channel_profile/channel_profile_model.dart';
import 'package:stream_vids/repository/user/get_channel_profile/channel_profile_repository.dart';
import 'package:stream_vids/utils/utils.dart';

class GetChannelProfileController extends GetxController {
  final _api = ChannelProfileRepository();
  var isLoading = true.obs;
  var channelProfile = Data().obs;

  @override
  void onInit() {
    super.onInit();
    getChannelProfile();
  }

  void getChannelProfile() async {
    isLoading(true);
    try {
      final response = await _api.getChannelProfile();
      if(response['statusCode'] == 200) {
        final channelProfileModel = ChannelProfileModel.fromJson(response);
      if (channelProfileModel.success!) {
        Get.delete<GetChannelProfileController>();
        channelProfile.value = channelProfileModel.data!;
      } else {
        Utils.snackBar("Error", channelProfileModel.message!);
      }
      }else{
        Utils.snackBar("Error", response['message']);
      }
    } catch (e) {
      Utils.snackBar("Error", "Error occurred while fetching data: $e");
    } finally {
      isLoading(false);
    }
  }
}
