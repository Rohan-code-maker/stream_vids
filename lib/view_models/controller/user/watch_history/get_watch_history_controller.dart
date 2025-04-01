import 'package:get/get.dart';
import 'package:stream_vids/models/user/watch_history/get_watch_history_model.dart';
import 'package:stream_vids/repository/user/watch_history/get_watch_history_repository.dart';
import 'package:stream_vids/utils/utils.dart';

class GetWatchHistoryController extends GetxController {
  final _api = GetWatchHistoryRepository();
  var watchHistory = [].obs;
  var isLoading = false.obs;

  Future<void> fetchWatchHistory() async {
    try {
      isLoading.value = true;
      final response = await _api.getWatchHistory();
      if (response['statusCode'] == 200) {
        final model = GetWatchHistoryModel.fromJson(response);
        if (model.data!.isNotEmpty) {
          Get.delete<GetWatchHistoryController>();
          watchHistory.assignAll(model.data!);
        } else {
          Utils.snackBar("error".tr, model.message!);
        }
      } else {
        Utils.snackBar('error'.tr, response['message']);
      }
    } catch (e) {
      final String err = Utils.extractErrorMessage(e.toString());
      Utils.snackBar('error'.tr, err);
    } finally {
      isLoading.value = false;
    }
  }
}
