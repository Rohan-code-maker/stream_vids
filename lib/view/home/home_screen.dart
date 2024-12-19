import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stream_vids/view_models/controller/logout_controller/logout_controller.dart';
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
    splashServices.isLogin();
  }

  final logoutController = Get.put(LogoutController());
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
    );
  }
}
