import 'dart:async';
import 'package:get/get.dart';
import 'package:stream_vids/res/routes/route_name.dart';
import 'package:stream_vids/utils/utils.dart';
import 'package:stream_vids/view_models/controller/user_preferences/user_preferences.dart';

class SplashServices {
  final UserPreferences userPreferences = UserPreferences();

  void isLogin() async {
    try {
      // Get the user data
      final userData = await userPreferences.getUser();

      // Navigate based on access token availability
      await Future.delayed(const Duration(microseconds: 2));

      if (userData.accessToken == null || userData.accessToken!.isEmpty) {
        // Navigate to Login Screen
        Get.toNamed(RouteName.loginScreen);
      } else {
        // Navigate to Home Screen
        Get.toNamed(RouteName.homeScreen);
      }
    } catch (error) {
      Utils.snackBar("Error", "An error occurred: $error");
    }
  }
}
