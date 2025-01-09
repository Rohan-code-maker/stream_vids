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
    return Scaffold(
      appBar: AppBar(
        title: Text('liked_videos'.tr),
        centerTitle: true,
      ),
      body: Obx(() {
        if (getLikedVideoController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if(getLikedVideoController.likedVideos.isEmpty) {
          return const Center(child: Text('No liked videos found.'));
        }
        else {
          return ListView.builder(
            itemCount: getLikedVideoController.likedVideos.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(getLikedVideoController.likedVideos[index].title),
                subtitle:
                    Text(getLikedVideoController.likedVideos[index].description),
                leading: Image.network(
                    getLikedVideoController.likedVideos[index].thumbnail),
                onTap: () {
                  Get.toNamed(
                    RouteName.videoScreen.replaceFirst(
                        ':videoId', getLikedVideoController.likedVideos[index].videoId),
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
