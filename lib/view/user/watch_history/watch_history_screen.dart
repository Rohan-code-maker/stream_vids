import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stream_vids/res/routes/route_name.dart';
import 'package:stream_vids/view_models/controller/user/watch_history/get_watch_history_controller.dart';
import 'package:stream_vids/view_models/services/splash_services.dart';

class WatchHistoryScreen extends StatefulWidget {
  const WatchHistoryScreen({super.key});

  @override
  State<WatchHistoryScreen> createState() => _WatchHistoryScreenState();
}

class _WatchHistoryScreenState extends State<WatchHistoryScreen> {
  final _controller = Get.put(GetWatchHistoryController());

  SplashServices splashServices = SplashServices();
  @override
  void initState() {
    super.initState();
    splashServices.handleAppNavigation();
    _refreshVideos();
  }

  Future<void> _refreshVideos() async {
    _controller.fetchWatchHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("watch_history".tr),
        centerTitle: true,
      ),
      body: Obx(() {
        if (_controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: _controller.watchHistory.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(_controller.watchHistory[index].title),
                subtitle: Text(_controller.watchHistory[index].description),
                leading:
                    Image.network(_controller.watchHistory[index].thumbnail),
                onTap: () {
                  Get.toNamed(
                    RouteName.videoScreen.replaceFirst(
                        ':videoId', _controller.watchHistory[index].sId),
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
