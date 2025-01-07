import 'package:get/get.dart';
import 'package:stream_vids/models/video_folder/get_liked_videos/like_count_model.dart';
import 'package:stream_vids/repository/video_folder/like_video_repository/like_count_repository.dart';
import 'package:stream_vids/utils/utils.dart';

class LikeCountController extends GetxController {
  RxInt likeCount = 0.obs;
  final _api = LikeCountRepository();

  void count(String videoId) async {
    try {
      final response = await _api.getLikeCount(videoId);
      if (response['statusCode'] == 200) {
        final model = LikeCountModel.fromJson(response);
        if (model.success!) {
          likeCount.value = model.data!.likeCount!;
        } else {
          Utils.snackBar(
              "Error", "Failed to fetch like count: ${model.message}");
        }
      } else {
        Utils.snackBar("Error", "${response["message"]}");
      }
    } catch (e) {
      Utils.snackBar("Error", "Failed before Api call: $e");
    }
  }
}
