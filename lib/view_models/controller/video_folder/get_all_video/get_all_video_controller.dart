import 'package:get/get.dart';
import 'package:stream_vids/models/video_folder/get_all_videos/get_all_video_model.dart';
import 'package:stream_vids/repository/video_folder/get_all_video_repository/get_all_video_repository.dart';
import 'package:stream_vids/utils/utils.dart';

class GetAllVideoController extends GetxController {
  final GetAllVideoRepository _api = GetAllVideoRepository();

  var isLoading = false.obs;
  var videoList = [].obs;
  var currentPage = 1.obs;
  var isLastPage = false.obs;

  @override
  void onInit() {
    super.onInit();
    getAllVideo(isInitial: true);
  }

  void getAllVideo({bool isInitial = false}) async {
    if (isLoading.value || isLastPage.value) return;

    if (isInitial) {
      currentPage.value = 1;
      videoList.clear();
      isLastPage.value = false;
    }

    isLoading(true);
    try {
      final response = await _api.getAllVideoApi(page: currentPage.value);
      final videoModel = GetAllVideoModel.fromJson(response);
      if (videoModel.success) {
        final newVideos = videoModel.data.videos;
        if (newVideos.isEmpty || newVideos.length < 10) {
          isLastPage(true);
        }
        videoList.addAll(newVideos);
        currentPage.value++;
      } else {
        Utils.snackBar("error".tr, videoModel.message);
      }
    } catch (e) {
      final String err = Utils.extractErrorMessage(e.toString());
      Utils.snackBar("error".tr, "Error occurred while fetching data: $err");
    } finally {
      isLoading(false);
    }
  }
}
