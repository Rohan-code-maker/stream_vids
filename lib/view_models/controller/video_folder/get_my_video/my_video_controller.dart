import 'package:get/get.dart';
import 'package:stream_vids/models/video_folder/get_my_videos/my_video_model.dart';
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
          Utils.snackBar("Error", "${model.message}");
        }
      } else {
        Utils.snackBar("Error", "${response['message']}");
      }
    } catch (e) {
      Utils.snackBar("Error", "Error while loading video");
    } finally {
      loading(false);
    }
  }
}
