import 'package:get/get.dart';
import 'package:stream_vids/models/video_folder/comment/toggle_comment_like_model.dart';
import 'package:stream_vids/models/video_folder/comment/view_comment_model.dart';
import 'package:stream_vids/models/video_folder/get_liked_videos/get_video_like_status_model.dart';
import 'package:stream_vids/models/video_folder/get_liked_videos/like_count_model.dart';
import 'package:stream_vids/repository/video_folder/comment/count_comment_likes_repository.dart';
import 'package:stream_vids/repository/video_folder/comment/get_comment_like_repository.dart';
import 'package:stream_vids/repository/video_folder/comment/toggle_comment_like_repository.dart';
import 'package:stream_vids/repository/video_folder/comment/view_comment_repository.dart';
import 'package:stream_vids/utils/utils.dart';

class ViewCommentController extends GetxController {
  final _viewCommentRepo = ViewCommentRepository();
  final _commentLikeStatus = GetCommentLikeRepository();
  final _countCommentLike = CountCommentLikesRepository();
  final _toggleCommentLike = ToggleCommentLikeRepository();

  var comments = <Comments>[].obs;
  var isLikedMap = <String, RxBool>{}; // Map for like status
  var likeCountMap = <String, RxInt>{}; // Map for like count

  Future<void> viewComment(String videoId) async {
    // Fetch comments from API
    final fetchedComments = await _viewCommentRepo.viewCommentRepo(videoId);
    if (fetchedComments['statusCode'] == 200) {
      final model = ViewCommentModel.fromJson(fetchedComments);
      if (model.success!) {
        comments.assignAll(model.data!.comments!);

        // Initialize like status and count for each comment
        for (var comment in model.data!.comments!) {
          final commentId = comment.sId!;
          isLikedMap[commentId] = RxBool(false);
          likeCountMap[commentId] = RxInt(0);

          // Fetch the like status and count for the comment
          fetchCommentLikeStatus(commentId);
          fetchCommentLikeCount(commentId);
        }
      } else {
        Utils.snackBar("Error", model.message!);
      }
    } else {
      Utils.snackBar("Error", fetchedComments['message']);
    }
  }

  Future<void> fetchCommentLikeStatus(String commentId) async {
    try {
      final status = await _commentLikeStatus.getCommentLikeRepo(commentId);
      if (status['statusCode'] == 200) {
        final model = GetVideoLikeStatusModel.fromJson(status);
        if (model.success!) {
          isLikedMap[commentId]?.value = model.data!.isLiked!;
        } else {
          Utils.snackBar("Error", model.message!);
        }
      } else {
        Utils.snackBar("Error", status['message']);
      }
    } catch (e) {
      print("Error fetching like status for comment $commentId: $e");
    }
  }

  Future<void> fetchCommentLikeCount(String commentId) async {
    try {
      final count = await _countCommentLike.countCommentLikesRepo(commentId);
      if (count['statusCode'] == 200) {
        final model = LikeCountModel.fromJson(count);
        if (model.success!) {
          likeCountMap[commentId]?.value = model.data!.likeCount!;
        } else {
          Utils.snackBar("Error", model.message!);
        }
      } else {
        Utils.snackBar("Error", count['message']);
      }
    } catch (e) {
      print("Error fetching like count for comment $commentId: $e");
    }
  }

  Future<void> toggleCommentLike(String commentId) async {
    try {
      final response =
          await _toggleCommentLike.toggleCommentLikeRepo(commentId);
      if (response['statusCode'] == 200) {
        final model = ToggleCommentLikeModel.fromJson(response);
        if (model.success!) {
          fetchCommentLikeStatus(commentId);
          fetchCommentLikeCount(commentId);
        }else{
          Utils.snackBar("Error", model.message!);
        }
      }else{
        Utils.snackBar("Error", response['message']);
      }
    } catch (e) {
      print("Error toggling like for comment $commentId: $e");
    }
  }
}
