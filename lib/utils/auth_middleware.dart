import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stream_vids/res/routes/route_name.dart';
import 'package:stream_vids/res/user_preferences/user_preferences.dart';
import 'package:stream_vids/utils/utils.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    loginStatus();
    // If access token is valid, allow navigation to the requested screen
    return null;
  }

  void loginStatus() async {
    try {
      UserPreferences userPreferences = UserPreferences();
      final user = await userPreferences.getUser();
      if (user.accessToken!.isEmpty) {
        Get.offAllNamed(RouteName.loginScreen);
      }
    } catch (e) {
      final String err = Utils.extractErrorMessage(e.toString());
      Utils.snackBar("Error", err);
    }
  }
}
