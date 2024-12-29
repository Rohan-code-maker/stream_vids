import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stream_vids/res/routes/route_name.dart';
import 'package:stream_vids/view_models/controller/user/get_channel_profile/get_channel_profile_controller.dart';
import 'package:stream_vids/view_models/controller/user/logout_controller/logout_controller.dart';
import 'package:stream_vids/view_models/services/splash_services.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GetChannelProfileController _controller = Get.put(GetChannelProfileController());

  final logoutController = Get.put(LogoutController());

  SplashServices splashServices = SplashServices();

  @override
  void initState() {
    super.initState();
    splashServices.handleAppNavigation();
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

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "FullName: ${user.fullname}",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "UserName: ${user.username}",
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                "Email: ${user.email}",
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                "Subscribers: ${user.subscribersCount}",
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                "Channel subscribed to: ${user.channelsSubscribedToCount}",
                style: const TextStyle(fontSize: 16),
              ),
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
                title: Text("watch_history".tr),
                onTap: () {
                  Get.toNamed(RouteName.watchHistory);
                },
              ),
              ListTile(
                title: Text("logout".tr),
                onTap: () {
                  logoutController.logout();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
