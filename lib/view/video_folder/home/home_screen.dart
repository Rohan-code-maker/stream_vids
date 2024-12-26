import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stream_vids/res/routes/route_name.dart';
import 'package:stream_vids/view_models/controller/video_folder/get_all_video/get_all_video_controller.dart';
import 'package:stream_vids/view_models/controller/user/logout_controller/logout_controller.dart';
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

  final logoutController = Get.put(LogoutController());
  final getAllVideoController = Get.put(GetAllVideoController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('home_screen'.tr),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              logoutController.logout();
            },
          )
        ],
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
                  Get.toNamed(
                    RouteName.videoScreen.replaceFirst(
                        ':videoId', getAllVideoController.videoList[index].id),
                  );
                  if (kDebugMode) {
                    print(
                        'Navigating to: ${RouteName.videoScreen.replaceFirst(':videoId', getAllVideoController.videoList[index].id)}');
                    print('Get.parameters: ${Get.parameters}');
                  }
                },
              );
            },
          );
        }
      }),
    );
  }
}
