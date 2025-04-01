import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stream_vids/models/user/change_password/change_password_model.dart';
import 'package:stream_vids/repository/user/change_password_repository/change_password_repository.dart';
import 'package:stream_vids/res/routes/route_name.dart';
import 'package:stream_vids/utils/utils.dart';
import 'package:stream_vids/res/user_preferences/user_preferences.dart';

class ChangePasswordController extends GetxController {
  final _api = ChangePasswordRepository();
  final userPreferences = UserPreferences();

  // Non-observable TextEditingControllers
  final oldPasswordController = TextEditingController().obs;
  final newPasswordController = TextEditingController().obs;

  final oldPasswordFocusNode = FocusNode().obs;
  final newPasswordFocusNode = FocusNode().obs;

  // Loading state as observable
  RxBool loading = false.obs;

  void changePassword() async {
    loading.value = true;

    // Create login request data
    Map<String, String> data = {
      "oldPassword": oldPasswordController.value.text.trim(),
      "newPassword": newPasswordController.value.text.trim(),
    };

    try {
      final user = await userPreferences.getUser();
      final accessToken = user.accessToken;
      if (accessToken != null) {
        // Call login API
        final response = await _api.changePasswordApi(data);

        final model = ChangePasswordModel.fromJson(response);

        if (model.statusCode == 200) {
          Get.delete<ChangePasswordController>();
          Get.toNamed(RouteName.navBarScreen);
          Utils.snackBar("success".tr, "password_changed_successfully".tr);
        } else {
          Utils.snackBar("error".tr, "password_change_failed".tr);
        }
      }
    } catch (error) {
      final String err = Utils.extractErrorMessage(error.toString());
      Utils.snackBar("error".tr, err);
    }finally{
      loading.value = false;
    }
  }
}
