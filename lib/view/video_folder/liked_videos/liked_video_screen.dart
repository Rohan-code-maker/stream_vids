import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stream_vids/res/routes/route_name.dart';
import 'package:stream_vids/view_models/controller/video_folder/get_like_video/get_liked_videos_controller.dart';

class LikedVideoScreen extends StatefulWidget {
  const LikedVideoScreen({super.key});

  @override
  State<LikedVideoScreen> createState() => _LikedVideoScreenState();
}

class _LikedVideoScreenState extends State<LikedVideoScreen> {
  final getLikedVideoController = GetLikedVideosController();

  @override
  void initState() {
    super.initState();
    getLikedVideoController.fetchLikedVideos();
  }

  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('liked_videos'.tr),
        centerTitle: true,
      ),
      body: Obx(() {
        if (getLikedVideoController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (getLikedVideoController.likedVideos.isEmpty) {
          return const Center(child: Text('No liked videos found.'));
        } else {
          return LayoutBuilder(
            builder: (context, constraints) {
              final isLargeScreen = constraints.maxWidth > 600;

              return GridView.builder(
                padding: const EdgeInsets.all(16.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isLargeScreen ? 4 : 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: isLargeScreen
                      ? mq.aspectRatio * 0.5
                      : mq.aspectRatio * 1,
                ),
                itemCount: getLikedVideoController.likedVideos.length,
                itemBuilder: (context, index) {
                  final video = getLikedVideoController.likedVideos[index];
                  final brightness = Theme.of(context).brightness;

                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    elevation: brightness == Brightness.light ? 4.0 : 2.0,
                    color: brightness == Brightness.light
                        ? Colors.white
                        : Colors.grey[800],
                    child: InkWell(
                      onTap: () {
                        Get.toNamed(
                          RouteName.videoScreen.replaceFirst(':videoId', video.videoId),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(12.0),
                            ),
                            child: Image.network(
                              video.thumbnail,
                              width: double.infinity,
                              height: isLargeScreen
                                  ? mq.height * 0.3
                                  : mq.height * 0.3,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: mq.height * 0.01),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Text(
                              video.title,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: isLargeScreen
                                    ? mq.width * 0.03
                                    : mq.width * 0.03,
                                fontWeight: FontWeight.bold,
                                color: brightness == Brightness.light
                                    ? Colors.black
                                    : Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(height: mq.height * 0.01),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Text(
                              video.description,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: isLargeScreen
                                    ? mq.width * 0.01
                                    : mq.width * 0.03,
                                color: brightness == Brightness.light
                                    ? Colors.grey
                                    : Colors.grey[400],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        }
      }),
    );
  }
}
