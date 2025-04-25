import 'package:get/get.dart';
import 'package:stream_vids/models/user/logout/logout_model.dart';
import 'package:stream_vids/models/video_folder/get_my_videos/my_video_model.dart';
import 'package:stream_vids/repository/video_folder/delete_video_repository/delete_video_repository.dart';
import 'package:stream_vids/repository/video_folder/get_my_video_repository/my_video_repository.dart';
import 'package:stream_vids/utils/utils.dart';

class MyVideoController extends GetxController {
  final _api = MyVideoRepository();
  RxBool loading = false.obs;
  var videoList = [].obs;

  @override
  void onInit() {
    super.onInit();
    myVideos();
  }

  void myVideos() async {
    loading(true);
    try {
      final response = await _api.getMyVideo();
      if (response['statusCode'] == 200) {
        final model = MyVideoModel.fromJson(response);
        if (model.statusCode == 200) {
          videoList.assignAll(model.data!.myVideos!);
          Get.delete<MyVideoController>();
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
      loading(false);
    }
  }

  final _api2 = DeleteVideoRepository();

  void deleteVideo(String url) async {
    loading.value = true;
    try {
      final response = await _api2.deleteVideo(url);
      if (response['statusCode'] == 200) {
        final model = LogoutModel.fromJson(response);
        if (model.success!) {
          Utils.snackBar("success".tr, "video_deleted".tr);
          myVideos();
        } else {
          Utils.snackBar("error".tr, model.message.toString());
        }
      } else {
        Utils.snackBar("error".tr, "$response['message]");
      }
    } catch (e) {
      final String err = Utils.extractErrorMessage(e.toString());
      Utils.snackBar("error".tr, err);
    } finally {
      loading.value = false;
    }
  }
}
