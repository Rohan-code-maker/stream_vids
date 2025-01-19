import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stream_vids/res/routes/route_name.dart';
import 'package:stream_vids/utils/utils.dart';
import 'package:stream_vids/res/user_preferences/user_preferences.dart';
import 'package:stream_vids/view_models/services/language_service.dart';

class SplashServices {
  final UserPreferences userPreferences = UserPreferences();
  final LanguageService languageService = LanguageService();

  Future<void> handleAppNavigation() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      bool isFirstTime = prefs.getBool('isFirstTime') ?? true;
      Duration splashDelay = isFirstTime
          ? const Duration(seconds: 2)
          : const Duration(milliseconds: 500);
      await Future.delayed(splashDelay);

      if (isFirstTime) {
        // If the user is opening the app for the first time, navigate to LanguageScreen.
        Get.offNamed(RouteName.languageScreen);
        await prefs.setBool('isFirstTime', false);
      } else {
        // Check login status to determine navigation.
        await _checkLoginStatus();
      }
    } catch (error) {
      final String err = Utils.extractErrorMessage(error.toString());
      Utils.snackBar("Error", "An error occurred: $err");
    }
  }

  Future<void> _checkLoginStatus() async {
    final userData = await userPreferences.getUser();
    if (userData.accessToken == null || userData.accessToken!.isEmpty) {
      Get.offNamed(RouteName.loginScreen);
    } else {
      Get.offNamed(RouteName.navBarScreen);
    }
  }
}
