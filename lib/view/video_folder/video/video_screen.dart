import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chewie/chewie.dart';
import 'package:stream_vids/utils/utils.dart';
import 'package:stream_vids/view_models/controller/user/subscribe_user/subscribe_status_controller.dart';
import 'package:stream_vids/view_models/controller/user/subscribe_user/subscribe_user_controller.dart';
import 'package:stream_vids/view_models/controller/video_folder/get_video_like_status/get_video_like_status_controller.dart';
import 'package:stream_vids/view_models/controller/video_folder/like_video/like_video_controller.dart';
import 'package:video_player/video_player.dart';
import 'package:stream_vids/view_models/controller/video_folder/get_video_byid/get_video_byid_controller.dart';

class VideoScreen extends StatefulWidget {
  final String videoId;

  const VideoScreen({super.key, required this.videoId});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  final _controller = Get.put(GetVideoByIdController());
  final likeController = Get.put(LikeVideoController());
  final likeStatusController = Get.put(GetVideoLikeStatusController());
  final subscriptionController = Get.put(SubscribeUserController());
  final subscriptionStatusController = Get.put(SubscribeStatusController());

  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  final TextEditingController _commentController = TextEditingController();
  final List<String> comments = <String>[].obs;

  @override
  void initState() {
    super.initState();
    _controller.fetchVideoById(widget.videoId);
    likeStatusController.fetchLikeStatus(widget.videoId);
  }

  @override
  void dispose() {
    Get.delete<GetVideoByIdController>();
    Get.delete<LikeVideoController>();
    Get.delete<GetVideoLikeStatusController>();
    Get.delete<SubscribeUserController>();
    Get.delete<SubscribeStatusController>();
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    _commentController.dispose();
    super.dispose();
  }

  void initializeVideoPlayer(String videoUrl) {
    _videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(videoUrl));
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: false,
    );

    _videoPlayerController.initialize().then((_) {
      setState(() {});
    }).catchError((error, stackTrace) {
      if (kDebugMode) {
        print("Error initializing video: $error");
        print("StackTrace: $stackTrace");
      }
      Utils.snackBar("Error", "Error initializing video: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("video_screen".tr),
        centerTitle: true,
      ),
      body: Obx(() {
        if (_controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final video = _controller.video.value;

        if (video == null) {
          return Center(child: Text("no_video".tr));
        }

        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_chewieController == null && video.videoFile != null) {
            initializeVideoPlayer(video.videoFile!);
          }
          subscriptionStatusController.getSubscribedStatus(video.owner!);
        });

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (_chewieController != null)
                  AspectRatio(
                    aspectRatio: _videoPlayerController.value.aspectRatio,
                    child: Chewie(controller: _chewieController!),
                  )
                else
                  const Center(child: CircularProgressIndicator()),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        video.title ?? "Untitled",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(video.description ?? "No description available."),
                      Text(video.duration.toString()),
                      Text(video.views.toString()),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Obx(() => IconButton(
                                icon: Icon(
                                  likeStatusController.isliked.value
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: likeStatusController.isliked.value
                                      ? Colors.red
                                      : Colors.grey,
                                ),
                                onPressed: () {
                                  try {
                                    // Toggle the like status
                                    likeController.likeVideo(widget.videoId);
                                    likeStatusController
                                        .fetchLikeStatus(widget.videoId);
                                  } catch (e) {
                                    Utils.snackBar("Error",
                                        "Failed to update like status: $e");
                                  }
                                },
                              )),
                          const SizedBox(width: 16),
                          Obx(() => ElevatedButton(
                                onPressed: () {
                                  subscriptionController
                                      .subscribe(video.owner!);
                                  subscriptionStatusController
                                      .getSubscribedStatus(video.owner!);
                                },
                                child: Text(
                                  subscriptionStatusController
                                          .isSubscribed.value
                                      ? "unsubscribe".tr
                                      : "subscribe".tr,
                                ),
                              )),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Divider(),
                      Text(
                        "comments".tr,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _commentController,
                        decoration: InputDecoration(
                          hintText: "add_comment".tr,
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.send),
                            onPressed: () {
                              if (_commentController.text.trim().isNotEmpty) {
                                comments.add(_commentController.text.trim());
                                _commentController.clear();
                              }
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Obx(() => ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: comments.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(comments[index]),
                              );
                            },
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
