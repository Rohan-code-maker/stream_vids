import 'package:get/get.dart';
import 'package:stream_vids/models/video_folder/like_videos/like_videos_model.dart';
import 'package:stream_vids/repository/video_folder/like_video_repository/like_video_repository.dart';
import 'package:stream_vids/utils/utils.dart';

class LikeVideoController extends GetxController {
  final _api = LikeVideoRepository();
  void likeVideo(String videoId) async {
    try {
      final response = await _api.likeVideoRepo(videoId);
      if (response['statusCode'] == 200) {
        final model = LikeModel.fromJson(response);
        if (model.success! == false) {
          Utils.snackBar("Error", "${model.message}");
        }
      } else {
        Utils.snackBar("Error", "${response['message']}");
      }
    } catch (e) {
      Utils.snackBar("Error", "$e");
    }
  }
}
