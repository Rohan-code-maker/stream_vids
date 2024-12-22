import 'dart:async';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stream_vids/res/routes/route_name.dart';
import 'package:stream_vids/utils/utils.dart';
import 'package:stream_vids/view_models/controller/user_preferences/user_preferences.dart';

class SplashServices {
  final UserPreferences userPreferences = UserPreferences();

  void isLogin() async {
    try {
      // Check if the app is opened for the first time
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

      // If it's the first time, delay for 2 seconds
      Duration splashDelay = isFirstTime ? const Duration(seconds: 2) : const Duration(microseconds: 2);

      // Simulate splash screen delay
      await Future.delayed(splashDelay);
      // Get the user data
      final userData = await userPreferences.getUser();

      if (userData.accessToken == null || userData.accessToken!.isEmpty) {
        // Navigate to Login Screen
        Get.toNamed(RouteName.loginScreen);
      } else {
        // Navigate to Home Screen
        Get.toNamed(RouteName.homeScreen);
      }

      if (isFirstTime) {
        prefs.setBool('isFirstTime', false);
      }
    } catch (error) {
      Utils.snackBar("Error", "An error occurred: $error");
    }
  }
}
