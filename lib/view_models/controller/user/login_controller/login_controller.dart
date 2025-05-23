import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stream_vids/models/user/login/login_model.dart';
import 'package:stream_vids/repository/user/login_repository/login_repository.dart';
import 'package:stream_vids/res/routes/route_name.dart';
import 'package:stream_vids/utils/utils.dart';
import 'package:stream_vids/res/user_preferences/user_preferences.dart';

class LoginController extends GetxController {
  final _api = LoginRepository();
  final userPreferences = UserPreferences();

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
      final response = await _api.loginApi(data);
      if (response == null || !response.containsKey('data')) {
        Utils.snackBar("error".tr, "invalid_response".tr);  
      }

      final dataModel = Data.fromJson(response['data']);

      if (dataModel.accessToken != null) {
        final isSaved = await userPreferences.saveUser(dataModel);
        if (isSaved) {
          Get.delete<LoginController>();
          Get.offAllNamed(RouteName.navBarScreen);
          Utils.snackBar("success".tr, "login_success".tr);
          clearFields();
        } else {
          Utils.snackBar("error".tr, "failed_to_save_user".tr);
        }
      } else {
        Utils.snackBar("error".tr, "login_failed".tr);
      }
    } catch (error) {
      final String err = Utils.extractErrorMessage(error.toString());
      Utils.snackBar("error".tr, "${'login_failed'.tr} $err");
    } finally {
      loading.value = false;
    }
  }

  void clearFields() {
    emailController.value.clear();
    passwordController.value.clear();
  }
}
