import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stream_vids/res/routes/route_name.dart';
import 'package:stream_vids/view_models/controller/user/watch_history/add_watch_history_controller.dart';
import 'package:stream_vids/view_models/controller/video_folder/get_all_video/get_all_video_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final getAllVideoController = Get.put(GetAllVideoController());
  final addWatchHistory = Get.put(AddWatchHistoryController());

  @override
  void initState() {
    super.initState();
    getAllVideoController.getAllVideo();
  }

  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('home_screen'.tr),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.message_outlined),
            onPressed: () {
              // Implement search functionality here
              Get.toNamed(RouteName.chatScreen);
            },
          ),
        ],
      ),
      body: Obx(() {
        if (getAllVideoController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
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
                itemCount: getAllVideoController.videoList.length,
                itemBuilder: (context, index) {
                  final video = getAllVideoController.videoList[index];
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
                        addWatchHistory.addToWatchHistory(video.id);
                        Get.toNamed(
                          RouteName.videoScreen
                              .replaceFirst(':videoId', video.id),
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
                                    : mq.width * 0.05,
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
                              video.createdBy.username,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: isLargeScreen
                                    ? mq.width * 0.02
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
