import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stream_vids/res/components/input_field.dart';
import 'package:stream_vids/res/components/round_btn.dart';
import 'package:stream_vids/utils/utils.dart';
import 'package:stream_vids/view_models/controller/user/forgot_password/forgot_password_controller.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _controller = Get.put(ForgotPasswordController());
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('forgot_password'.tr),
      ),
      body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InputField(
                    hintText: 'email_hint'.tr,
                    labelText: 'email_hint'.tr,
                    controller:
                        _controller.emailController.value,
                    currentFocusNode:
                        _controller.emailFocusNode.value,
                    nextFocusNode:
                        _controller.usernameFocusNode.value,
                    validator: (value) {
                      if (value!.isEmpty) {
                        Utils.toastMessageBottom("email_hint".tr);
                      }
                      if (value.length < 8) {
                        Utils.toastMessageBottom("email_hint".tr);
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: mq.height * .1,
                  ),
                  InputField(
                    hintText: 'username_hint'.tr,
                    labelText: 'username_hint'.tr,
                    controller:
                        _controller.usernameController.value,
                    currentFocusNode:
                        _controller.usernameFocusNode.value,
                    nextFocusNode:
                        _controller.newPasswordFocusNode.value,
                    validator: (value) {
                      if (value!.isEmpty) {
                        Utils.toastMessageBottom("username_hint".tr);
                      }
                      if (value.length < 8) {
                        Utils.toastMessageBottom("username_hint".tr);
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: mq.height * .1,
                  ),
                  InputField(
                    obscure: true,
                    hintText: 'new_password_hint'.tr,
                    labelText: 'new_password_hint'.tr,
                    controller:
                        _controller.newPasswordController.value,
                    currentFocusNode:
                        _controller.newPasswordFocusNode.value,
                    nextFocusNode:
                        _controller.usernameFocusNode.value,
                    validator: (value) {
                      if (value!.isEmpty) {
                        Utils.toastMessageBottom("new_password_hint".tr);
                      }
                      if (value.length < 8) {
                        Utils.toastMessageBottom("new_password_hint".tr);
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: mq.height * .1,
                  ),
                  Obx(() => RoundBtn(
                      loading: _controller.loading.value,
                      title: "login".tr,
                      width: mq.width * .35,
                      onPress: () {
                        if (_formKey.currentState!.validate()) {
                          _controller.forgotPassword();
                        }
                      })),
                ],
              ),
            ),
          )),
    );
  }
}