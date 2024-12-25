import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stream_vids/models/change_password/change_password_model.dart';
import 'package:stream_vids/repository/forgot_password/forgot_password_repository.dart';
import 'package:stream_vids/res/routes/route_name.dart';
import 'package:stream_vids/utils/utils.dart';

class ForgotPasswordController extends GetxController {
  final _api = ForgotPasswordRepository();

  final emailController = TextEditingController().obs;
  final usernameController = TextEditingController().obs;
  final newPasswordController = TextEditingController().obs;

  final emailFocusNode = FocusNode().obs;
  final usernameFocusNode = FocusNode().obs;
  final newPasswordFocusNode = FocusNode().obs;

  RxBool loading = false.obs;

  void forgotPassword() async {
    loading.value = true;
    Map<String, String> data = {
      "email": emailController.value.text.trim(),
      "username": usernameController.value.text.trim(),
      "newPassword": newPasswordController.value.text.trim(),
    };
    try {
      final response = await _api.forgotPasswordApi(data);
      final model = ChangePasswordModel.fromJson(response);
      if (model.statusCode == 200) {
        Get.delete<ForgotPasswordController>();
        Utils.snackBar("Success", "Password Reset Successful");
        Get.toNamed(RouteName.loginScreen);
      }
    } catch (e) {
      Utils.snackBar(
          "Error", "Password Changes failed. Please check your credentials.");
    }finally{
      loading.value = false;
    }
  }
}