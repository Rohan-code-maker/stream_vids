import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:stream_vids/models/user/logout/logout_model.dart';
import 'package:stream_vids/models/video_folder/comment/add_comment_model.dart';
import 'package:stream_vids/models/video_folder/comment/toggle_comment_like_model.dart';
import 'package:stream_vids/models/video_folder/comment/update_comment_model.dart';
import 'package:stream_vids/models/video_folder/comment/view_comment_model.dart';
import 'package:stream_vids/models/video_folder/get_liked_videos/get_video_like_status_model.dart';
import 'package:stream_vids/models/video_folder/get_liked_videos/like_count_model.dart';
import 'package:stream_vids/repository/video_folder/comment/add_comment_repository.dart';
import 'package:stream_vids/repository/video_folder/comment/count_comment_likes_repository.dart';
import 'package:stream_vids/repository/video_folder/comment/delete_comment_repository.dart';
import 'package:stream_vids/repository/video_folder/comment/get_comment_like_repository.dart';
import 'package:stream_vids/repository/video_folder/comment/toggle_comment_like_repository.dart';
import 'package:stream_vids/repository/video_folder/comment/update_comment_repository.dart';
import 'package:stream_vids/repository/video_folder/comment/view_comment_repository.dart';
import 'package:stream_vids/res/user_preferences/user_preferences.dart';
import 'package:stream_vids/utils/utils.dart';

class ViewCommentController extends GetxController {
  final _viewCommentRepo = ViewCommentRepository();
  final _commentLikeStatus = GetCommentLikeRepository();
  final _countCommentLike = CountCommentLikesRepository();
  final _toggleCommentLike = ToggleCommentLikeRepository();
  final _updateComment = UpdateCommentRepository();
  final _deleteComment = DeleteCommentRepository();

  var comments = <Comments>[].obs;
  var isLikedMap = <String, RxBool>{}; // Map for like status
  var likeCountMap = <String, RxInt>{}; // Map for like count
  var ownerMap = <String, RxBool>{};
  TextEditingController updateController = TextEditingController();
  UserPreferences userPreferences = UserPreferences();

  final _api = AddCommentRepository();
  final commentController = TextEditingController().obs;
  final commentFocusNode = FocusNode().obs;
  RxBool isloading = false.obs;

  Future<void> addComment(String videoId) async {
    isloading.value = true;
    Map<String, dynamic> content = {'content': commentController.value.text};
    try {
      final response = await _api.addCommentRepo(videoId, content);
      if (response["statusCode"] == 200) {
        final model = AddCommentModel.fromJson(response);
        if (model.success!) {
          clear();
          viewComment(videoId);
        }
      } else {
        Utils.snackBar("Error", "$response['message']");
      }
    } catch (e) {
      final String err = Utils.extractErrorMessage(e.toString());
      Utils.snackBar("error".tr, err);
    } finally {
      isloading.value = false;
    }
  }

  void clear() {
    commentController.value.text = "";
  }

  Future<void> viewComment(String videoId) async {
    final user = await userPreferences.getUser();
    final commentOwner = user.user!.sId;
    // Fetch comments from API
    try {
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
            ownerMap[commentId] =
                RxBool(commentOwner == comment.commentedBy!.sId);

            // Fetch the like status and count for the comment
            fetchCommentLikeStatus(commentId);
            fetchCommentLikeCount(commentId);
          }
        } else {
          Utils.snackBar("error".tr, model.message!);
        }
      } else {
        Utils.snackBar("error".tr, fetchedComments['message']);
      }
    } catch (e) {
      final String err = Utils.extractErrorMessage(e.toString());
      Utils.snackBar("error".tr, err);
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
          Utils.snackBar("error".tr, model.message!);
        }
      } else {
        Utils.snackBar("error".tr, status['message']);
      }
    } catch (e) {
      final String err = Utils.extractErrorMessage(e.toString());
      Utils.snackBar("error".tr, err);
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
          Utils.snackBar("error".tr, model.message!);
        }
      } else {
        Utils.snackBar("error".tr, count['message']);
      }
    } catch (e) {
      final String err = Utils.extractErrorMessage(e.toString());
      Utils.snackBar("error".tr, err);
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
        } else {
          Utils.snackBar("error".tr, model.message!);
        }
      } else {
        Utils.snackBar("error".tr, response['message']);
      }
    } catch (e) {
      final String err = Utils.extractErrorMessage(e.toString());
      Utils.snackBar("error".tr, err);
    }
  }

  Future<void> updateComment(String commentId) async {
    try {
      Map<String, dynamic> content = {'content': updateController.text};
      final response = await _updateComment.updateComment(commentId, content);
      if (response['statusCode'] == 200) {
        final model = UpdateCommentModel.fromJson(response);
        if (model.success!) {
          updateController.clear();
        } else {
          Utils.snackBar("error".tr, model.message!);
        }
      } else {
        Utils.snackBar("error".tr, response['message']);
      }
    } catch (e) {
      final String err = Utils.extractErrorMessage(e.toString());
      Utils.snackBar("error".tr, err);
    }
  }

  Future<void> deleteComment(String commentId) async {
    try {
      final response = await _deleteComment.deleteComment(commentId);
      if (response['statusCode'] == 200) {
        final model = LogoutModel.fromJson(response);
        if (!model.success!) {
          Utils.snackBar("error".tr, model.message!);
        }
      } else {
        Utils.snackBar("error".tr, response['message']);
      }
    } catch (e) {
      final String err = Utils.extractErrorMessage(e.toString());
      Utils.snackBar("error".tr, err);
    }
  }
}
