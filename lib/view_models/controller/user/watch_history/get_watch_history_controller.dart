import 'package:get/get.dart';
import 'package:stream_vids/repository/user/watch_history/get_watch_history_repository.dart';

class GetWatchHistoryController extends GetxController {
  final _api = GetWatchHistoryRepository();
  var watchHistory = [].obs;
  var isLoading = false.obs;

  Future<void> fetchWatchHistory() async {
    try {
      isLoading.value = true;
      final response =await _api.getWatchHistory();
      if (response['statusCode'] == 200) {
        watchHistory.assignAll(response['data']['watchHistory']);
      } else {
        Get.snackbar('Error', 'Failed to fetch Watch History');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
