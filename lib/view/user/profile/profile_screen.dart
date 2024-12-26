import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stream_vids/res/routes/route_name.dart';
import 'package:stream_vids/view_models/controller/user/get_current_user/current_user_controller.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final CurrentUserController _controller = Get.put(CurrentUserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Obx(() {
        if (_controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final user = _controller.currentUser.value;

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
                      fontSize: 20, fontWeight: FontWeight.bold),
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
                Expanded(
                    child: ListView(children: [
                  InkWell(
                    child: ListTile(
                      title: Text("update_account".tr),
                    ),
                    onTap: () {
                      Get.toNamed(RouteName.updateAccountScreen);
                    },
                  ),
                  InkWell(
                    child: ListTile(
                      title: Text("update_avatar".tr),
                    ),
                    onTap: () {
                      Get.toNamed(RouteName.updateAvatarScreen);
                    },
                  ),
                  InkWell(
                    child: ListTile(
                      title: Text("update_coverimage".tr),
                    ),
                    onTap: () {
                      Get.toNamed(RouteName.updateCoverImageScreen);
                    },
                  ),
                ]))
              ],
            ));
      }),
    );
  }
}
