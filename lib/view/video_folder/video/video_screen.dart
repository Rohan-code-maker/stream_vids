import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chewie/chewie.dart';
import 'package:stream_vids/res/routes/route_name.dart';
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

class _VideoScreenState extends State<VideoScreen> {
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
      Utils.snackBar("error".tr, "${'error_init_video'.tr} $error");
    });
  }

  void showEditDialog(String commentId, String currentContent) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("edit_comment".tr),
          content: TextField(
            controller: viewCommentController.updateController,
            decoration: InputDecoration(hintText: "update_comment".tr),
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: Text("cancel".tr),
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
                  Utils.snackBar("error".tr, "comment_cannot_empty".tr);
                }
              },
              child: Text("save".tr),
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
          title: Text("delete_comment".tr),
          content: Text("are_you_sure_you_want_to_delete".tr),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: Text("cancel".tr),
            ),
            ElevatedButton(
              onPressed: () {
                viewCommentController.deleteComment(commentId).then((_) {
                  viewCommentController.viewComment(widget.videoId);
                });

                Get.back();
              },
              child: Text("delete".tr),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

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
          final isWideScreen = constraints.maxWidth > 800;

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
              subscriptionController.getSubscribedStatus(video.owner!.sId!);
            });

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: isWideScreen
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 5,
                            child:
                                _buildVideoInfoSection(video, mq, isWideScreen,isDarkMode),
                          ),
                          Container(
                            width: 1.5, 
                            height: mq.height,
                            color: Colors.grey,
                            margin: const EdgeInsets.symmetric(horizontal: 16.0),
                          ),
                          Expanded(
                            flex: 2,
                            child: SingleChildScrollView(
                                child: _buildCommentsSection(
                                    video, mq, isWideScreen,isDarkMode)),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          _buildVideoInfoSection(video, mq, isWideScreen,isDarkMode),
                          const SizedBox(height: 16),
                          const Divider(),
                          _buildCommentsSection(video, mq, isWideScreen,isDarkMode),
                        ],
                      ),
              ),
            );
          });
        },
      ),
    );
  }

  Widget _buildVideoInfoSection(video, mq, isWideScreen,isDarkMode) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_chewieController != null)
            AspectRatio(
              aspectRatio: isWideScreen
                  ? (mq.width /
                      (mq.height *
                          0.8)) // Wider screens get a larger width ratio
                  : (mq.width /
                      (mq.height *
                          0.4)), // Smaller screens have a more square aspect
              child: Chewie(controller: _chewieController!),
            )
          else
            const Center(child: CircularProgressIndicator()),
          SizedBox(height: mq.height * 0.02),
          Text(
            video.title!.toUpperCase(),
            style: TextStyle(
              fontFamily: 'Times New Roman',
              fontSize: isWideScreen ? mq.width * 0.03 : mq.width * 0.05,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: mq.height * 0.02),
          Text(
            "${'desc'.tr} ${video.description!.toUpperCase()}",
            style: TextStyle(fontSize: mq.width * 0.03),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: mq.height * 0.02),
          Obx(() => Text("${'total_views'.tr} ${viewCountController.views.value}")),
          SizedBox(height: mq.height * 0.02),
          Text("${'uploaded'.tr} ${Utils.timeAgo(video.createdAt!)}"),
          SizedBox(height: mq.height * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Obx(() => IconButton(
                        icon: Icon(
                          likeController.isliked.value
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: likeController.isliked.value
                              ? Colors.red
                              : Colors.grey,
                        ),
                        onPressed: () {
                          likeController.likeVideo(widget.videoId);
                        },
                      )),
                  Text(likeController.likeCount.value.toString()),
                ],
              ),
              InkWell(
                onTap: () {
                  Get.toNamed(
                    RouteName.userScreen.replaceFirst(":userId", video.owner!.sId),
                  );
                },
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(video.owner!.avatar ?? ''),
                      backgroundColor: Colors.grey.shade200,
                    ),
                    SizedBox(width: mq.width * 0.01),
                    Text("@${video.owner!.username}"),
                  ],
                ),
              ),
              Obx(() => ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        subscriptionController.isSubscribed.value
                            ? const Color.fromARGB(255, 238, 230, 229)
                            : const Color(0xFFE62117),
                      ),
                    ),
                    onPressed: () {
                      subscriptionController.subscribe(video.owner!.sId!);
                    },
                    child: Text(
                      style: const TextStyle(color: Colors.black),
                      subscriptionController.isSubscribed.value
                          ? "subscribed".tr
                          : "subscribe".tr,
                    ),
                  )),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCommentsSection(video, mq, isWideScreen, isDarkMode) {
    return Column(
      children: [
        Text(
          "comments".tr,
        ),
        SizedBox(height: mq.height * 0.03),
        TextField(
          controller: viewCommentController.commentController.value,
          focusNode: viewCommentController.commentFocusNode.value,
          decoration: InputDecoration(
            hintText: "add_comment".tr,
            suffixIcon: IconButton(
              icon: const Icon(Icons.send),
              onPressed: () {
                if (viewCommentController.commentController.value.text
                    .trim()
                    .isNotEmpty) {
                  viewCommentController.addComment(widget.videoId);
                  viewCommentController.viewComment(widget.videoId);
                }
              },
            ),
          ),
        ),
        SizedBox(height: mq.height * 0.03),
        Obx(() {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: viewCommentController.comments.length,
            itemBuilder: (context, index) {
              final comment = viewCommentController.comments[index];
              final commentId = comment.sId!;

              return AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: 1.0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: InkWell(
                    onTap: (){
                      Get.toNamed(
                        RouteName.userScreen.replaceFirst(":userId", comment.commentedBy!.sId!),
                      );
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage:
                              NetworkImage(comment.commentedBy?.avatar ?? ''),
                          backgroundColor: Colors.grey.shade200,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                comment.commentedBy?.username ?? "Unknown",
                              ),
                              SizedBox(height: mq.height * 0.02),
                              Text(comment.content ?? ""),
                              SizedBox(height: mq.height * 0.02),
                              Row(
                                children: [
                                  Obx(() => IconButton(
                                        onPressed: () {
                                          viewCommentController
                                              .toggleCommentLike(commentId);
                                        },
                                        icon: Icon(
                                          viewCommentController
                                                      .isLikedMap[commentId]
                                                      ?.value ??
                                                  false
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: viewCommentController
                                                      .isLikedMap[commentId]
                                                      ?.value ??
                                                  false
                                              ? Colors.red
                                              : Colors.grey,
                                        ),
                                      )),
                                  Obx(() => Text(
                                      '${viewCommentController.likeCountMap[commentId]?.value ?? 0}')),
                                  if (viewCommentController.ownerMap
                                          .containsKey(commentId) &&
                                      (viewCommentController
                                          .ownerMap[commentId]!.value)) ...[
                                    IconButton(
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.blue,
                                      ),
                                      onPressed: () {
                                        showEditDialog(
                                            commentId, comment.content ?? "");
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      onPressed: () {
                                        confirmDeleteComment(commentId);
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
                ),
              );
            },
          );
        }),
      ],
    );
  }
}
