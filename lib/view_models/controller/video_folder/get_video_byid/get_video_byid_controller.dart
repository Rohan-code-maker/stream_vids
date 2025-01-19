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

      if (response['statusCode'] == 200) {
        final model = VideoModel.fromJson(response);
        if (model.success!) {
          video.value = model.data!.video;
        } else {
          video.value = null;
          Utils.snackBar("Error", "${model.message}");
        }
      } else {
        Utils.snackBar(
            "Error", "$response['message'] ?? Failed to fetch video");
      }
    } catch (e) {
      final String err = Utils.extractErrorMessage(e.toString());
      Utils.snackBar("Error", err);
    } finally {
      isLoading(false);
    }
  }
}
