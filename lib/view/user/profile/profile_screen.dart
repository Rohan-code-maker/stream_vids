import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stream_vids/res/routes/route_name.dart';
import 'package:stream_vids/utils/utils.dart';
import 'package:stream_vids/view_models/controller/theme_change/theme_controller.dart';
import 'package:stream_vids/view_models/controller/user/get_channel_profile/get_channel_profile_controller.dart';
import 'package:stream_vids/view_models/controller/user/logout_controller/logout_controller.dart';
import 'package:stream_vids/view_models/controller/video_folder/delete_video/delete_video_controller.dart';
import 'package:stream_vids/view_models/controller/video_folder/get_my_video/my_video_controller.dart';

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
  final ThemeController themeController = Get.find();

  @override
  void initState() {
    super.initState();
    _refreshVideos();
  }

  Future<void> _refreshVideos() async {
    videoController.myVideos();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final bool isWideScreen = mq.width > 800;

    return Scaffold(
      appBar: AppBar(
        title: Text('profile_screen'.tr),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          if (!isWideScreen)
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
          return Center(child: Text("no_data".tr));
        }

        return LayoutBuilder(
          builder: (context, constraints) {
            final bool isWide =
                constraints.maxWidth > 800; // Desktop breakpoint

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        // Profile Header with Cover Image and Avatar
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              width: double.infinity,
                              height: mq.height * 0.25,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(user.coverImage != ""
                                      ? user.coverImage!
                                      : 'https://images.pexels.com/photos/30472746/pexels-photo-30472746/free-photo-of-gilled-mushrooms-in-brazilian-forest.jpeg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: -50,
                              left: (constraints.maxWidth / 2) - 50,
                              child: CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.white,
                                backgroundImage: user.avatar != null
                                    ? NetworkImage(user.avatar!)
                                    : const NetworkImage(
                                        'https://via.placeholder.com/150.png?text=Avatar'),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: mq.height * 0.06),

                        // User Info Card
                        Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: isWide
                                ? Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                          child:
                                              _buildUserInfo(user, mq, isWide)),
                                      const SizedBox(width: 16),
                                      Expanded(
                                          child: _buildUserStats(user, mq)),
                                    ],
                                  )
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _buildUserInfo(user, mq, isWide),
                                      Divider(height: mq.height * 0.001),
                                      _buildUserStats(user, mq),
                                    ],
                                  ),
                          ),
                        ),
                        SizedBox(
                            height:
                                isWide ? mq.height * 0.03 : mq.height * 0.05),

                        // Video List Section
                        Obx(() {
                          if (videoController.loading.value) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          if (videoController.videoList.isEmpty) {
                            return Center(
                                child: Text("no_data".tr));
                          }
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: videoController.videoList.length,
                            itemBuilder: (context, index) {
                              final video = videoController.videoList[index];
                              return Card(
                                elevation: 2,
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                child: ListTile(
                                  key: ValueKey(video.sId),
                                  contentPadding: const EdgeInsets.all(8),
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      video.thumbnail ?? '',
                                      width: isWide ? mq.width * 0.08 : mq.width * 0.1,
                                      height: isWide ? mq.width * 0.1 : mq.width * 0.3,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  title: Text(
                                    video.title.toString().toUpperCase(),
                                    style: TextStyle(
                                      fontSize: isWide
                                          ? mq.width * 0.03
                                          : mq.height * 0.02,
                                    ),
                                    maxLines: 1, // Ensures only one line
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  trailing: Wrap(
                                    spacing: 8,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.edit,
                                            color: Colors.blue),
                                        onPressed: () {
                                          Get.toNamed(
                                            RouteName.updateVideoScreen
                                                .replaceFirst(
                                                    ':videoId', video.sId),
                                            arguments: {
                                              'title': video.title,
                                              'description': video.description,
                                            },
                                          );
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete,
                                            color: Colors.red),
                                        onPressed: () {
                                          Utils.showConfirmation(
                                            context: context,
                                            title: "delete_video".tr,
                                            message:
                                                "are_you_sure",
                                            onConfirm: () {
                                              deleteVideoController
                                                  .deleteVideo(video.sId);
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    Get.toNamed(
                                      RouteName.videoScreen
                                          .replaceFirst(':videoId', video.sId),
                                    );
                                  },
                                ),
                              );
                            },
                          );
                        }),
                      ],
                    ),
                  ),
                ),

                // Show drawer only in desktop view
                if (isWide)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _buildDrawerContent(),
                  ),
              ],
            );
          },
        );
      }),
      endDrawer: isWideScreen ? null : _buildDrawerContent(),
    );
  }

  Widget _buildUserInfo(user, mq, isWide) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          user.fullname ?? "N/A",
          style: TextStyle(
            fontSize: isWide ? mq.width * 0.03 : mq.width * 0.05,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: mq.height * 0.01),
        Text(
          "@${user.username ?? "N/A"}",
          style: TextStyle(
              fontSize: isWide ? mq.width * 0.02 : mq.width * 0.04,
              color: Colors.grey),
        ),
        SizedBox(height: mq.height * 0.01),
        Text(
          user.email ?? "N/A",
          style: TextStyle(
            fontSize: isWide ? mq.width * 0.02 : mq.width * 0.04,
          ),
        ),
      ],
    );
  }

  Widget _buildUserStats(user, mq) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildStatItem("subscribers".tr, user.subscribersCount ?? 0, mq),
        _buildStatItem("subscribed".tr, user.channelsSubscribedToCount ?? 0, mq),
      ],
    );
  }

  Widget _buildStatItem(String label, int count, mq) {
    return Column(
      children: [
        Text(
          "$count",
          style: TextStyle(
            fontSize: mq.width * 0.04,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildDrawerContent() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
           DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'settings'.tr,
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
            title: Text("change_theme".tr),
            onTap: () {
              themeController.changeTheme();
            },
          ),
          ListTile(
            title: Text("logout".tr),
            onTap: () {
              Utils.showConfirmation(
                context: context,
                title: "logout".tr,
                message: "sure_logout".tr,
                onConfirm: () {
                  logoutController.logout();
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
