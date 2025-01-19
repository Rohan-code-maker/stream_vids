import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chewie/chewie.dart';
import 'package:stream_vids/res/user_preferences/user_preferences.dart';
import 'package:stream_vids/utils/utils.dart';
import 'package:stream_vids/view_models/controller/user/subscribe_user/subscribe_user_controller.dart';
import 'package:stream_vids/view_models/controller/video_folder/comment/view_comment_controller.dart';
import 'package:stream_vids/view_models/controller/video_folder/like_video/like_video_controller.dart';
import 'package:stream_vids/view_models/controller/video_folder/views_count/views_count_controller.dart';
import 'package:video_player/video_player.dart';
import 'package:stream_vids/view_models/controller/video_folder/get_video_byid/get_video_byid_controller.dart';

class VideoScreen extends StatefulWidget {
  final String videoId;

  const VideoScreen({super.key, required this.videoId});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen>
    with SingleTickerProviderStateMixin {
  final _controller = Get.put(GetVideoByIdController());
  final likeController = Get.put(LikeVideoController());
  final subscriptionController = Get.put(SubscribeUserController());
  final viewCommentController = Get.put(ViewCommentController());
  final viewCountController = Get.put(ViewsCountController());

  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  UserPreferences preferences = UserPreferences();

  @override
  void initState() {
    super.initState();
    _controller.fetchVideoById(widget.videoId);
    likeController.count(widget.videoId);
    likeController.fetchLikeStatus(widget.videoId);
    viewCommentController.viewComment(widget.videoId);
    viewCountController.viewCount(widget.videoId);
  }

  @override
  void dispose() {
    Get.delete<GetVideoByIdController>();
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
      setState(() {});
    }).catchError((error, stackTrace) {
      Utils.snackBar("Error", "Error initializing video: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;

    void showEditDialog(String commentId, String currentContent) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Edit Comment"),
            content: TextField(
              controller: viewCommentController.updateController,
              decoration:
                  const InputDecoration(hintText: "Update your comment"),
            ),
            actions: [
              TextButton(
                onPressed: () => Get.back(),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () {
                  final content = viewCommentController.updateController.text;
                  if (content.isNotEmpty) {
                    viewCommentController.updateComment(commentId).then((_) {
                      viewCommentController.viewComment(widget.videoId);
                    });

                    Get.back();
                  } else {
                    Utils.snackBar("Error", "Comment cannot be empty");
                  }
                },
                child: const Text("Save"),
              ),
            ],
          );
        },
      );
    }

    void confirmDeleteComment(String commentId) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Delete Comment"),
            content:
                const Text("Are you sure you want to delete this comment?"),
            actions: [
              TextButton(
                onPressed: () => Get.back(),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () {
                  viewCommentController.deleteComment(commentId).then((_) {
                    viewCommentController.viewComment(widget.videoId);
                  });

                  Get.back();
                },
                child: const Text("Delete"),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("video_screen".tr),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWideScreen = constraints.maxWidth > 600;
          final theme = Theme.of(context);

          return Obx(() {
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
              subscriptionController.getSubscribedStatus(video.owner!);
            });

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: SizedBox(
                  width: isWideScreen ? mq.width * 0.5 : mq.width,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (_chewieController != null)
                          AspectRatio(
                            aspectRatio:
                                _videoPlayerController.value.aspectRatio,
                            child: Chewie(controller: _chewieController!),
                          )
                        else
                          const Center(child: CircularProgressIndicator()),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surface,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                video.title!.toUpperCase(),
                                style: TextStyle(
                                    fontFamily: 'Times New Roman',
                                    fontSize: isWideScreen
                                        ? mq.width * 0.03
                                        : mq.width * 0.05,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: mq.height * 0.03),
                              Text(
                                "Description: ${video.description!.toUpperCase()}",
                                style: TextStyle(fontSize: mq.width * 0.03),
                              ),
                              SizedBox(height: mq.height * 0.03),
                              Obx(() => Text(
                                  "Total Views: ${viewCountController.views.value.toString()}")),
                              SizedBox(height: mq.height * 0.03),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Obx(() => IconButton(
                                            icon: Icon(
                                              likeController.isliked.value
                                                  ? Icons.favorite
                                                  : Icons.favorite_border,
                                              color:
                                                  likeController.isliked.value
                                                      ? Colors.red
                                                      : Colors.grey,
                                            ),
                                            onPressed: () {
                                              likeController
                                                  .likeVideo(widget.videoId);
                                            },
                                          )),
                                      Text(likeController.likeCount.value
                                          .toString()),
                                    ],
                                  ),
                                  Obx(() => ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                WidgetStateProperty.all(
                                                    subscriptionController
                                                            .isSubscribed.value
                                                        ? const Color.fromARGB(
                                                            255, 245, 64, 51)
                                                        : const Color.fromARGB(
                                                            255,
                                                            200,
                                                            199,
                                                            199))),
                                        onPressed: () {
                                          subscriptionController
                                              .subscribe(video.owner!);
                                        },
                                        child: Text(
                                          subscriptionController
                                                  .isSubscribed.value
                                              ? "subscribed".tr
                                              : "subscribe".tr,
                                        ),
                                      )),
                                ],
                              ),
                              const SizedBox(height: 16),
                              const Divider(),
                              Text(
                                "comments".tr,
                              ),
                              const SizedBox(height: 8),
                              TextField(
                                controller: viewCommentController
                                    .commentController.value,
                                focusNode: viewCommentController
                                    .commentFocusNode.value,
                                decoration: InputDecoration(
                                  hintText: "add_comment".tr,
                                  suffixIcon: IconButton(
                                    icon: const Icon(Icons.send),
                                    onPressed: () {
                                      if (viewCommentController
                                          .commentController.value.text
                                          .trim()
                                          .isNotEmpty) {
                                        viewCommentController
                                            .addComment(widget.videoId);
                                        viewCommentController
                                            .viewComment(widget.videoId);
                                      }
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Obx(() {
                                return ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount:
                                      viewCommentController.comments.length,
                                  itemBuilder: (context, index) {
                                    final comment =
                                        viewCommentController.comments[index];
                                    final commentId = comment.sId!;

                                    return AnimatedOpacity(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      opacity: 1.0,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0, horizontal: 16.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CircleAvatar(
                                              radius: 20,
                                              backgroundImage: NetworkImage(
                                                  comment.commentedBy?.avatar ??
                                                      ''),
                                              backgroundColor:
                                                  Colors.grey.shade200,
                                            ),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    comment.commentedBy
                                                            ?.username ??
                                                        "Unknown",
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Text(comment.content ?? ""),
                                                  const SizedBox(height: 10),
                                                  Row(
                                                    children: [
                                                      Obx(() => IconButton(
                                                            onPressed: () {
                                                              viewCommentController
                                                                  .toggleCommentLike(
                                                                      commentId);
                                                            },
                                                            icon: Icon(
                                                              viewCommentController
                                                                          .isLikedMap[
                                                                              commentId]
                                                                          ?.value ??
                                                                      false
                                                                  ? Icons
                                                                      .favorite
                                                                  : Icons
                                                                      .favorite_border,
                                                              color: viewCommentController
                                                                          .isLikedMap[
                                                                              commentId]
                                                                          ?.value ??
                                                                      false
                                                                  ? Colors.red
                                                                  : Colors.grey,
                                                            ),
                                                          )),
                                                      Obx(() => Text(
                                                          '${viewCommentController.likeCountMap[commentId]?.value ?? 0}')),
                                                      if (viewCommentController
                                                              .ownerMap
                                                              .containsKey(
                                                                  commentId) &&
                                                          (viewCommentController
                                                              .ownerMap[
                                                                  commentId]!
                                                              .value)) ...[
                                                        IconButton(
                                                          icon: const Icon(
                                                              Icons.edit),
                                                          onPressed: () {
                                                            showEditDialog(
                                                                commentId,
                                                                comment.content ??
                                                                    "");
                                                          },
                                                        ),
                                                        IconButton(
                                                          icon: const Icon(
                                                              Icons.delete),
                                                          onPressed: () {
                                                            confirmDeleteComment(
                                                                commentId);
                                                          },
                                                        ),
                                                      ],
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          });
        },
      ),
    );
  }
}
