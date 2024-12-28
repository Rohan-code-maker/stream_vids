import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stream_vids/res/routes/route_name.dart';
import 'package:stream_vids/view_models/controller/user/watch_history/add_watch_history_controller.dart';
import 'package:stream_vids/view_models/controller/video_folder/get_all_video/get_all_video_controller.dart';
import 'package:stream_vids/view_models/services/splash_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SplashServices splashServices = SplashServices();
  @override
  void initState() {
    super.initState();
    splashServices.handleAppNavigation();
  }

  final addWatchHistoryController = Get.put(AddWatchHistoryController());
  final getAllVideoController = Get.put(GetAllVideoController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('home_screen'.tr),
        centerTitle: true,
      ),
      body: Obx(() {
        if (getAllVideoController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: getAllVideoController.videoList.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(getAllVideoController.videoList[index].title),
                subtitle:
                    Text(getAllVideoController.videoList[index].description),
                leading: Image.network(
                    getAllVideoController.videoList[index].thumbnail),
                onTap: () {
                  if (addWatchHistoryController.isLoading.value) {
                    addWatchHistoryController.addToWatchHistory(
                        getAllVideoController.videoList[index].id);
                  }
                  Get.toNamed(
                    RouteName.videoScreen.replaceFirst(
                        ':videoId', getAllVideoController.videoList[index].id),
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
