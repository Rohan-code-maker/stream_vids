import 'package:get/get.dart';
import 'package:stream_vids/models/video_folder/get_all_videos/get_all_video_model.dart';
import 'package:stream_vids/repository/video_folder/get_all_video_repository/get_all_video_repository.dart';
import 'package:stream_vids/utils/utils.dart';

class GetAllVideoController extends GetxController {
  final GetAllVideoRepository _api = GetAllVideoRepository();

  var isLoading = true.obs;
  var videoList = [].obs;

  @override
  void onInit() {
    getAllVideo();
    super.onInit();
  }

  void getAllVideo() async {
    isLoading(true);
    try {
      final response = await _api.getAllVideoApi();
      final videoModel = GetAllVideoModel.fromJson(response);
      if (videoModel.success) {
        if (videoModel.data.videos.isNotEmpty) {
          videoList.assignAll(videoModel.data.videos);
        } else {
          Utils.snackBar("Info", "No videos available.");
        }
      } else {
        Utils.snackBar("Error", videoModel.message);
      }
    } catch (e) {
      Utils.snackBar("Error", "Error occurred while fetching data: $e");
    } finally {
      isLoading(false);
    }
  }
}