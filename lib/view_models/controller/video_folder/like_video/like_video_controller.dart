import 'package:get/get.dart';
import 'package:stream_vids/models/video_folder/get_liked_videos/get_video_like_status_model.dart';
import 'package:stream_vids/models/video_folder/get_liked_videos/like_count_model.dart';
import 'package:stream_vids/models/video_folder/like_videos/like_videos_model.dart';
import 'package:stream_vids/repository/video_folder/like_video_repository/get_video_like_status_repository.dart';
import 'package:stream_vids/repository/video_folder/like_video_repository/like_count_repository.dart';
import 'package:stream_vids/repository/video_folder/like_video_repository/like_video_repository.dart';
import 'package:stream_vids/utils/utils.dart';

class LikeVideoController extends GetxController {
  final _api = LikeVideoRepository();
  RxInt likeCount = 0.obs;
  final _api2 = LikeCountRepository();
  final _api3 = GetVideoLikeStatusRepository();
  RxBool isliked = false.obs;

  Future<void> likeVideo(String videoId) async {
    try {
      final response = await _api.likeVideoRepo(videoId);
      if (response['statusCode'] == 200) {
        final model = LikeModel.fromJson(response);
        if (model.success!) {
          count(videoId);
          fetchLikeStatus(videoId);
        } else {
          Utils.snackBar("error".tr, "${model.message}");
        }
      } else {
        Utils.snackBar("error".tr, "${response['message']}");
      }
    } catch (e) {
      final String err = Utils.extractErrorMessage(e.toString());
      Utils.snackBar("error".tr, err);
    }
  }

  Future<void> count(String videoId) async {
    try {
      final response = await _api2.getLikeCount(videoId);
      if (response['statusCode'] == 200) {
        final model = LikeCountModel.fromJson(response);
        if (model.success!) {
          likeCount.value = model.data!.likeCount!;
        } else {
          Utils.snackBar(
              "error".tr, "Failed to fetch like count: ${model.message}");
        }
      } else {
        Utils.snackBar("error".tr, "${response["message"]}");
      }
    } catch (e) {
      final String err = Utils.extractErrorMessage(e.toString());
      Utils.snackBar("error".tr, err);
    }
  }

  Future<void> fetchLikeStatus(String videoId) async {
    try {
      final response = await _api3.getLikeStatus(videoId);
      if (response["statusCode"] == 200) {
        final model = GetVideoLikeStatusModel.fromJson(response);
        if (model.success!) {
          if (model.data!.isLiked!) {
            isliked.value = true;
          } else {
            isliked.value = false;
          }
        } else {
          Utils.snackBar("error".tr, "Failed to fetch likes: ${model.message}");
        }
      } else {
        Utils.snackBar(
            "error".tr, "Failed to fetch likes: ${response["message"]}");
      }
    } catch (e) {
      final String err = Utils.extractErrorMessage(e.toString());
      Utils.snackBar("error".tr, err);
    }
  }
}
