import 'package:get/get.dart';
import 'package:stream_vids/models/video_folder/get_all_videos/get_all_video_model.dart';
import 'package:stream_vids/repository/video_folder/get_all_video_repository/get_all_video_repository.dart';

class SearchVideoController extends GetxController {
  final GetAllVideoRepository _api = GetAllVideoRepository();
  var isLoading = false.obs;
  var videoList = [].obs;
  var query = ''.obs;
  var debounce = RxString('');

  @override
  void onInit() {
    debounce.listen((value) {
      if (value.isNotEmpty) {
        searchVideo(value);
      }
    });
    super.onInit();
  }

  void onSearchChanged(String value) {
    debounce.value = value;
  }

  void searchVideo(String searchQuery) async {
    query.value = searchQuery;

    if (searchQuery.isEmpty) {
      videoList.clear();
      return;
    }

    isLoading(true);
    try {
      final response = await _api.getAllVideoApi(query: searchQuery);
      final videoModel = GetAllVideoModel.fromJson(response);
      if (videoModel.success) {
        videoList.assignAll(videoModel.data.videos);
      } else {
        videoList.clear();
      }
    } catch (e) {
      videoList.clear();
      Get.snackbar(
        'Error',
        'Error occurred while searching for videos',
      );
    } finally {
      isLoading(false);
    }
  }
}
