import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stream_vids/models/login/login_model.dart';
import 'package:stream_vids/repository/login_repository/login_repository.dart';
import 'package:stream_vids/res/cookies/cookie_manager';
import 'package:stream_vids/res/routes/route_name.dart';
import 'package:stream_vids/utils/utils.dart';
import 'package:stream_vids/view_models/controller/user_preferences/user_preferences.dart';

class LoginController extends GetxController {
  final _api = LoginRepository();
  final userPreferences = UserPreferences();
  final cookieManager = CookieManager();

  // Non-observable TextEditingControllers
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;

  final emailFocusNode = FocusNode().obs;
  final passwordFocusNode = FocusNode().obs;

  // Loading state as observable
  RxBool loading = false.obs;

  void login() async {
    loading.value = true;

    // Create login request data
    Map<String, String> data = {
      "email": emailController.value.text.trim(),
      "password": passwordController.value.text.trim(),
    };

    try {
      // Call login API
      final response = await _api.loginApi(data);
      loading.value = false;

      final dataModel = Data.fromJson(response['data']);

      if (dataModel.accessToken != null) {
        // Save user data to preferences
        final isSaved = await userPreferences.saveUser(dataModel);
        cookieManager.setCookie('accessToken', dataModel.accessToken!);
        if (isSaved) {
          Get.delete<LoginController>();
          Get.toNamed(RouteName.homeScreen);
          Utils.snackBar("Success", "Login Successfully");
        } else {
          Utils.snackBar("Error", "Failed to save user data.");
        }
      } else {
        Utils.snackBar("Error", "Login failed.");
      }
    } catch (error) {
      loading.value = false;
      Utils.snackBar("Error", "Login failed. Please check your credentials.");
    }
  }
}
