import 'package:get/get.dart';
import 'package:stream_vids/models/video_folder/get_video_by_id/video_model.dart';
import 'package:stream_vids/repository/video_folder/get_video_by_id/video_repository.dart';
import 'package:stream_vids/utils/utils.dart';

class GetVideoByIdController extends GetxController {
  final GetVideoByIdRepository _api = GetVideoByIdRepository();

  var isLoading = false.obs;
  var video = Rxn<Video>();

  // Method to fetch video by ID
  void fetchVideoById(String videoId) async {
    isLoading(true);
    try {
      final response = await _api.getVideoByIdApi(videoId);

      if (response != null && response['success'] == true) {
        if (response['data'] != null && response['data']['videos'] != null) {
          // Assuming the backend returns a single video in the videos array for the given videoId
          final videos = response['data']['videos'];
          if (videos.isNotEmpty) {
            video.value = Video.fromJson(videos[0]); // Extract the first video
          } else {
            Utils.snackBar("Error", "No video found for the given ID");
          }
        } else {
          Utils.snackBar("Error", "Invalid response structure");
        }
      } else {
        Utils.snackBar(
            "Error", "$response['message'] ?? Failed to fetch video");
      }
    } catch (e) {
      Utils.snackBar("Error", "Error while fetching video");
    } finally {
      isLoading(false);
    }
  }
}
