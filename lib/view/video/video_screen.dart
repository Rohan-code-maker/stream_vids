import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chewie/chewie.dart';
import 'package:stream_vids/utils/utils.dart';
import 'package:video_player/video_player.dart';
import 'package:stream_vids/view_models/controller/get_video_byid/get_video_byid_controller.dart';

class VideoScreen extends StatefulWidget {
  final String videoId;

  const VideoScreen({super.key, required this.videoId});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  final GetVideoByIdController _controller = Get.put(GetVideoByIdController());

  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    _controller.fetchVideoById(widget.videoId);
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
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
      setState(() {}); // Ensure the UI updates after initialization
    }).catchError((error) {
      Utils.snackBar("Error", "Error initializing video: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
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
        });

        return SingleChildScrollView(
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
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
