import 'package:get/get.dart';
import 'package:stream_vids/models/video_folder/get_liked_videos/get_video_like_status_model.dart';
import 'package:stream_vids/repository/video_folder/like_video_repository/get_video_like_status_repository.dart';
import 'package:stream_vids/utils/utils.dart';

class GetVideoLikeStatusController extends GetxController {
  final _api = GetVideoLikeStatusRepository();
  RxBool isliked = false.obs;
  void fetchLikeStatus(String videoId) async {
    try {
      final response = await _api.getLikeStatus(videoId);
      if (response["statusCode"] == 200) {
        final model = GetVideoLikeStatusModel.fromJson(response);
        if (model.success!) {
          if (model.data!.isLiked!) {
            isliked.value = true;
          } else {
            isliked.value = false;
          }
        } else {
          Utils.snackBar("Error", "Failed to fetch likes: ${model.message}");
        }
      } else {
        Utils.snackBar(
            "Error", "Failed to fetch likes: ${response["message"]}");
      }
    } catch (e) {
      Utils.snackBar("Error", "Error fetching likes: $e");
    }
  }
}
