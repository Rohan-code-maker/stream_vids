import 'package:get/get.dart';
import 'package:stream_vids/models/video_folder/user_videos/user_videos_model.dart';
import 'package:stream_vids/repository/user/get_user_by_id/get_user_repository.dart';
import 'package:stream_vids/models/user/get_channel_profile/channel_profile_model.dart';
import 'package:stream_vids/repository/video_folder/get_user_videos/get_user_videos_repository.dart';
import 'package:stream_vids/utils/utils.dart';

class GetUserController extends GetxController {
  final _api = GetUserRepository();
  var isLoading = true.obs;
  var channelProfile = ChannelProfileModel().obs;
  final _api2 = GetUserVideosRepository();
  var videoList = <UserVideos>[].obs;

  void getUserById(userId) async {
    isLoading(true);
    try {
      final response = await _api.getUserById(userId);
      if (response['statusCode'] == 200) {
        final channelProfileModel = ChannelProfileModel.fromJson(response);
        if (channelProfileModel.success!) {
          channelProfile.value = channelProfileModel;
          userVideos(userId);
        } else {
          Utils.snackBar("Error", channelProfileModel.message!);
        }
      } else {
        Utils.snackBar("Error", response['message']);
      }
    } catch (e) {
      final String err = Utils.extractErrorMessage(e.toString());
      Utils.snackBar("Error", err);
    } finally {
      isLoading(false);
    }
  }

  void userVideos(userId) async {
    isLoading(true);
    try {
      final response = await _api2.getUserVideos(userId);
      if (response['statusCode'] == 200) {
        final model = UserVideosModel.fromJson(response);
        if (model.statusCode == 200) {
          videoList.assignAll(model.data!.userVideos!);
        } else {
          Utils.snackBar("Error", "${model.message}");
        }
      } else {
        Utils.snackBar("Error", "${response['message']}");
      }
    } catch (e) {
      final String err = Utils.extractErrorMessage(e.toString());
      Utils.snackBar("Error", err);
    } finally {
      isLoading(false);
    }
  }
}
