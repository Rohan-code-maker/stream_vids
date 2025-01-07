import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stream_vids/res/routes/route_name.dart';
import 'package:stream_vids/utils/utils.dart';
import 'package:stream_vids/view_models/controller/user/get_channel_profile/get_channel_profile_controller.dart';
import 'package:stream_vids/view_models/controller/user/logout_controller/logout_controller.dart';
import 'package:stream_vids/view_models/controller/video_folder/delete_video/delete_video_controller.dart';
import 'package:stream_vids/view_models/controller/video_folder/get_my_video/my_video_controller.dart';
import 'package:stream_vids/view_models/services/splash_services.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GetChannelProfileController _controller =
      Get.put(GetChannelProfileController());
  final MyVideoController videoController = Get.put(MyVideoController());
  final LogoutController logoutController = Get.put(LogoutController());
  final DeleteVideoController deleteVideoController =
      Get.put(DeleteVideoController());

  SplashServices splashServices = SplashServices();

  @override
  void initState() {
    super.initState();
    splashServices.handleAppNavigation();
    _refreshVideos();
  }

  Future<void> _refreshVideos() async {
    videoController.myVideos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              );
            },
          ),
        ],
      ),
      body: Obx(() {
        if (_controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final user = _controller.channelProfile.value;

        if (user.username == null || user.email == null) {
          return const Center(child: Text("No data available"));
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Full Name: ${user.fullname ?? "N/A"}",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "User Name: ${user.username ?? "N/A"}",
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                "Email: ${user.email ?? "N/A"}",
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                "Subscribers: ${user.subscribersCount ?? 0}",
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                "Channels Subscribed To: ${user.channelsSubscribedToCount ?? 0}",
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              Obx(() {
                if (videoController.loading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (videoController.videoList.isEmpty) {
                  return const Text("No videos found.");
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: videoController.videoList.length,
                  itemBuilder: (context, index) {
                    final video = videoController.videoList[index];
                    return ListTile(
                      title: Text(video.title ?? "No Title"),
                      subtitle: Text(video.description ?? "No Description"),
                      leading: Image.network(video.thumbnail ?? ""),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () {
                              // Handle the update logic here
                              Get.toNamed(
                                RouteName.updateVideoScreen
                                    .replaceFirst(':videoId', video.sId),
                                arguments: {
                                  'title': video.title,
                                  'description': video.description,
                                },
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              // Handle the delete logic here
                              Utils.showConfirmation(
                                  context: context,
                                  title: "Delete Video",
                                  message: "Are you sure you want to delete",
                                  onConfirm: () {
                                    deleteVideoController
                                        .deleteVideo(video.sId);
                                  });
                            },
                          ),
                        ],
                      ),
                      onTap: () {
                        // Handle the main tap action
                        Get.toNamed(
                          RouteName.videoScreen
                              .replaceFirst(':videoId', video.sId),
                        );
                      },
                    );
                  },
                );
              }),
            ],
          ),
        );
      }),
      endDrawer: Directionality(
        textDirection: TextDirection.rtl,
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  'setting'.tr,
                  style: const TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
              ListTile(
                title: Text("update_account".tr),
                onTap: () {
                  Get.toNamed(RouteName.updateAccountScreen);
                },
              ),
              ListTile(
                title: Text("update_avatar".tr),
                onTap: () {
                  Get.toNamed(RouteName.updateAvatarScreen);
                },
              ),
              ListTile(
                title: Text("update_coverimage".tr),
                onTap: () {
                  Get.toNamed(RouteName.updateCoverImageScreen);
                },
              ),
              ListTile(
                title: Text("change_password".tr),
                onTap: () {
                  Get.toNamed(RouteName.changePasswordScreen);
                },
              ),
              ListTile(
                title: Text("get_liked_videos".tr),
                onTap: () {
                  Get.toNamed(RouteName.likedVideoScreen);
                },
              ),
              ListTile(
                title: Text("logout".tr),
                onTap: () {
                  Utils.showConfirmation(
                      context: context,
                      title: "Logout",
                      message: "Are you sure want to Logout",
                      onConfirm: () {
                        logoutController.logout();
                      });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
