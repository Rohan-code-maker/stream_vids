import 'package:get/get.dart';
import 'package:stream_vids/models/video_folder/view_count/view_count_model.dart';
import 'package:stream_vids/repository/video_folder/views_count_repository/views_count_repository.dart';
import 'package:stream_vids/utils/utils.dart';

class ViewsCountController extends GetxController {
  final _api = ViewsCountRepository();
  RxInt views = 0.obs;

  void viewCount(String videoId) async {
    try {
      final response = await _api.getViewsCount(videoId);
      if (response['statusCode'] == 200) {
        final model = ViewsCountModel.fromJson(response);
        if (model.success!) {
          views.value = model.data!.views!;
        } else {
          Utils.snackBar("error".tr, model.message!);
        }
      }else{
        Utils.snackBar("error".tr, "Error: ${response['message']}");
      }
    } catch (e) {
      final String err = Utils.extractErrorMessage(e.toString());
      Utils.snackBar("error".tr, err);
    }
  }
}
