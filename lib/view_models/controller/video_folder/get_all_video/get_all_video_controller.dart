import 'package:get/get.dart';
import 'package:stream_vids/models/video_folder/get_all_videos/get_all_video_model.dart';
import 'package:stream_vids/repository/video_folder/get_all_video_repository/get_all_video_repository.dart';
import 'package:stream_vids/utils/utils.dart';

class GetAllVideoController extends GetxController {
  final GetAllVideoRepository _api = GetAllVideoRepository();

  var isLoading = true.obs;
  var videoList = [].obs;

  void getAllVideo() async {
    isLoading(true);
    try {
      final response = await _api.getAllVideoApi();
      final videoModel = GetAllVideoModel.fromJson(response);
      if (videoModel.success) {
        if (videoModel.data.videos.isNotEmpty) {
          videoList.assignAll(videoModel.data.videos);
          Get.delete<GetAllVideoController>();
        } else {
          Utils.snackBar("error".tr, "no_data".tr);
        }
      } else {
        Utils.snackBar("error".tr, videoModel.message);
      }
    } catch (e) {
      final String err = Utils.extractErrorMessage(e.toString());
      Utils.snackBar("error.tr", "Error occurred while fetching data: $err");
    } finally {
      isLoading(false);
    }
  }
}
