import 'dart:async';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stream_vids/res/routes/route_name.dart';
import 'package:stream_vids/utils/utils.dart';
import 'package:stream_vids/view_models/controller/user_preferences/user_preferences.dart';
import 'package:stream_vids/view_models/services/language_service.dart';

class SplashServices {
  final UserPreferences userPreferences = UserPreferences();
  final LanguageService languageService = LanguageService();

  Future<void> handleAppNavigation() async {
    try {
      // Get shared preferences instance
      SharedPreferences prefs = await SharedPreferences.getInstance();
      
      // Check if the app is opened for the first time
      bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

      // Simulate a splash screen delay
      Duration splashDelay = isFirstTime ? const Duration(seconds: 2) : const Duration(milliseconds: 500);
      await Future.delayed(splashDelay);

      if (isFirstTime) {
        // Navigate to LanguageScreen if the app is opened for the first time
        Get.toNamed(RouteName.languageScreen);
        prefs.setBool('isFirstTime', false);
      } else {
        // Check login status
        await _checkLoginStatus();
      }
    } catch (error) {
      Utils.snackBar("Error", "An error occurred: $error");
    }
  }

  Future<void> _checkLoginStatus() async {
    // Get saved user data
    final userData = await userPreferences.getUser();

    if (userData.accessToken == null || userData.accessToken!.isEmpty) {
      // Navigate to LoginScreen if the user is not logged in
      Get.toNamed(RouteName.loginScreen);
    } else {
      // Navigate to HomeScreen if the user is already logged in
      Get.toNamed(RouteName.homeScreen);
    }
  }
}
