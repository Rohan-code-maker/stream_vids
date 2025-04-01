import 'package:get/get.dart';
import 'package:stream_vids/models/user/logout/logout_model.dart';
import 'package:stream_vids/repository/video_folder/delete_video_repository/delete_video_repository.dart';
import 'package:stream_vids/res/routes/route_name.dart';
import 'package:stream_vids/utils/utils.dart';

class DeleteVideoController extends GetxController {
  final _api = DeleteVideoRepository();
  RxBool loading = false.obs;

  Future<void> deleteVideo(String url) async {
    loading.value = true;
    try {
      final response = await _api.deleteVideo(url);
      if (response['statusCode'] == 200) {
        final model = LogoutModel.fromJson(response);
        if (model.success!) {
          Get.delete<DeleteVideoController>();
          Get.toNamed(RouteName.profileScreen);
          Utils.snackBar("success".tr, "video_deleted".tr);
        } else {
          Utils.snackBar("error".tr, model.message.toString());
        }
      } else {
        Utils.snackBar("error".tr, "$response['message]");
      }
    } catch (e) {
      final String err = Utils.extractErrorMessage(e.toString());
      Utils.snackBar("error".tr, err);
    } finally {
      loading.value = false;
    }
  }
}
