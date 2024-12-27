import 'package:get/get.dart';
import 'package:stream_vids/repository/user/watch_history/add_watch_history_repository.dart';
import 'package:stream_vids/utils/utils.dart';

class AddWatchHistoryController extends GetxController {
  final _api = AddWatchHistoryRepository();
  Future<void> addToWatchHistory(String videoId) async {
    try {
      final response = await _api.addWatchHistory(videoId);
      if (response.statusCode == 200) {
        Utils.snackBar('Success', 'Video added to Watch History');
      } else {
        Utils.snackBar('Error', 'Failed to add video to Watch History');
      }
    } catch (e) {
      Utils.snackBar('Error', 'Something went wrong: $e');
    }
  }
}
