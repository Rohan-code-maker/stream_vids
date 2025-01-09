import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stream_vids/models/video_folder/comment/add_comment_model.dart';
import 'package:stream_vids/repository/video_folder/comment/add_comment_repository.dart';
import 'package:stream_vids/utils/utils.dart';

class AddCommentController extends GetxController {
  final _api = AddCommentRepository();
  final commentController = TextEditingController().obs;
  final commentFocusNode = FocusNode().obs;
  final commentOwner = Rxn<Comment>();
  RxBool isloading = false.obs;

  void addComment(String videoId) async {
    isloading.value = true;
    Map<String, dynamic> content = {'content': commentController.value.text};
    try {
      final response = await _api.addCommentRepo(videoId, content);
      if (response["statusCode"] == 200) {
        final model = AddCommentModel.fromJson(response);
        if (model.success!) {
          clear();
          commentOwner.value = model.data!.comment!;
        }
      } else {
        Utils.snackBar("Error", "$response['message']");
      }
    } catch (e) {
      Utils.snackBar("Error", "Api call error: $e");
    } finally {
      isloading.value = false;
    }
  }

  void clear() {
    commentController.value.text = "";
  }
}
