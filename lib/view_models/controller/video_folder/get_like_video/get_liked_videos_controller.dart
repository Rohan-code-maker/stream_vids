import 'package:get/get.dart';
import 'package:stream_vids/models/video_folder/get_liked_videos/get_liked_video_model.dart';
import 'package:stream_vids/repository/video_folder/get_liked_videos/get_liked_videos_repository.dart';
import 'package:stream_vids/utils/utils.dart';

class GetLikedVideosController extends GetxController {
  final repository = GetLikedVideosRepository();
  RxBool isLoading = false.obs;
  var likedVideos = [].obs;

  @override
  void onInit() {
    super.onInit();
    fetchLikedVideos(); // Fetch liked videos when the controller is initialized
  }

  // Fetch liked videos from the backend
  Future<void> fetchLikedVideos() async {
    try {
      isLoading.value = true;
      final response = await repository.getLikedVideos();
      GetLikedVideoModel likedVideosModel =
          GetLikedVideoModel.fromJson(response);

      if (likedVideosModel.success!) {
        likedVideos.assignAll(likedVideosModel.data!);
        Get.delete<GetLikedVideosController>();
      } else {
        Utils.snackBar("error".tr,
            "Failed to fetch liked videos: ${likedVideosModel.message}");
      }
    } catch (e) {
      final String err = Utils.extractErrorMessage(e.toString());
      Utils.snackBar("error".tr, err);
    } finally {
      isLoading.value = false;
    }
  }
}
