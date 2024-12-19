import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stream_vids/repository/register_repository/register_repository.dart';
import 'package:stream_vids/res/routes/route_name.dart';
import 'package:stream_vids/utils/utils.dart';

class RegisterController extends GetxController {
  final _api = RegisterRepository();

  final fullnameController = TextEditingController().obs;
  final usernameController = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final avatarController = TextEditingController().obs;
  final coverImageController = TextEditingController().obs;

  final fullnameFocusNode = FocusNode().obs;
  final usernameFocusNode = FocusNode().obs;
  final emailFocusNode = FocusNode().obs;
  final passwordFocusNode = FocusNode().obs;
  final avatarFocusNode = FocusNode().obs;
  final coverImageFocusNode = FocusNode().obs;

  RxBool loading = false.obs;

  void register() {
    loading.value = true;

    Map data = {
      "fullname": fullnameController.value.text,
      "username": usernameController.value.text,
      "email": emailController.value.text,
      "password": passwordController.value.text,
      "avatar": avatarController.value.text,
      "coverImage": coverImageController.value.text,
    };
    _api.registerApi(data).then((value) {
      loading.value = false;

      Get.delete<RegisterController>();

      Get.toNamed(RouteName.loginScreen)!.then((value) {});

      Utils.snackBar("Success", "Registration Successful");
    }).onError((error,stackTrace){
      loading.value = false;
      Utils.snackBar("Error", error.toString());
    });
  }
}
