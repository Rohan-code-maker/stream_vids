import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stream_vids/models/login/login_model.dart';
import 'package:stream_vids/repository/login_repository/login_repository.dart';
import 'package:stream_vids/res/routes/route_name.dart';
import 'package:stream_vids/utils/utils.dart';
import 'package:stream_vids/view_models/controller/user_preferences/user_preferences.dart';

class LoginController extends GetxController {
  final _api = LoginRepository();
  UserPreferences userPreferences = UserPreferences();

  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;

  final emailFocusNode = FocusNode().obs;
  final passwordFocusNode = FocusNode().obs;

  RxBool loading = false.obs;

  void login() {
    loading.value = true;
    Map data = {
      "email": emailController.value.text,
      "password": passwordController.value.text
    };

    _api.loginApi(data).then((value) {
      loading.value = false;

      userPreferences.saveUser(Data.fromJson(value)).then((value) {
        Get.delete<LoginController>();

        Get.toNamed(RouteName.homeScreen)!.then((value) {});
      }).onError((error, stackTrace) {});

      Utils.snackBar("Success", "Login Successfully");
    }).onError((error, stackTrace) {
      loading.value = false;
      Utils.snackBar("Error", error.toString());
    });
  }
}
