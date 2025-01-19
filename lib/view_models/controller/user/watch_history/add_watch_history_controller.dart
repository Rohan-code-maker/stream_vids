import 'package:get/get.dart';
import 'package:stream_vids/models/user/watch_history/add_watch_history_model.dart';
import 'package:stream_vids/repository/user/watch_history/add_watch_history_repository.dart';
import 'package:stream_vids/utils/utils.dart';

class AddWatchHistoryController extends GetxController {
  final _api = AddWatchHistoryRepository();

  void addToWatchHistory(String videoId) async {
    try {
      final response = await _api.addWatchHistory(videoId);
      if (response['statusCode'] == 200) {
        final model = AddWatchHistoryModel.fromJson(response);
        if (model.success!) {
          Get.delete<AddWatchHistoryController>();
        } else {
          Utils.snackBar('Error', '${model.message}');
        }
      } else {
        Utils.snackBar('Error', '$response["message"]');
      }
    } catch (e) {
      final String err = Utils.extractErrorMessage(e.toString());
      Utils.snackBar('Error', err);
    }
  }
}
