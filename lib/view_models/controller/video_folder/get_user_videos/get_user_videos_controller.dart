import 'package:get/get.dart';
import 'package:stream_vids/models/video_folder/user_videos/user_videos_model.dart';
import 'package:stream_vids/repository/video_folder/get_user_videos/get_user_videos_repository.dart';
import 'package:stream_vids/utils/utils.dart';

class GetUserVideosController extends GetxController{
  final _api2 = GetUserVideosRepository();
  var videoList = <UserVideos>[].obs;
  var isLoading = true.obs;
  
  void userVideos(userId) async {
    isLoading(true);
    try {
      final response = await _api2.getUserVideos(userId);
      if (response['statusCode'] == 200) {
        final model = UserVideosModel.fromJson(response);
        if (model.statusCode == 200) {
          videoList.assignAll(model.data!.userVideos!);
        } else {
          Utils.snackBar("error".tr, "${model.message}");
        }
      } else {
        Utils.snackBar("error".tr, "${response['message']}");
      }
    } catch (e) {
      final String err = Utils.extractErrorMessage(e.toString());
      Utils.snackBar("error".tr, err);
    } finally {
      isLoading(false);
    }
  }
}