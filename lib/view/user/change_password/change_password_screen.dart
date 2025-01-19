import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:stream_vids/res/components/input_field.dart';
import 'package:stream_vids/res/components/round_btn.dart';
import 'package:stream_vids/view_models/controller/user/change_password_controller/change_password_controller.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  ChangePasswordController changePasswordController =
      Get.put(ChangePasswordController());

  final _passwordKey = GlobalKey<FormState>();
  final RxBool _isPasswordObscured = true.obs;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('change_password'.tr),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWideScreen = constraints.maxWidth > 600;

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Container(
                  width: isWideScreen ? mq.width * 0.5 : mq.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    border: Border.all(
                      width: 2,
                      color: Colors.black,
                    ),
                  ),
                  child: Form(
                    key: _passwordKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: mq.height * 0.3,
                          child: Lottie.asset(
                            'assets/animation/forgot_password_animation.json',
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(height: mq.height * 0.1),
                        SizedBox(
                          width: isWideScreen ? mq.width * 0.3 : mq.width * 0.8,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Obx(() => InputField(
                                    obscure: true,
                                    hintText: 'old_password_hint'.tr,
                                    labelText: 'old_password_hint'.tr,
                                    controller: changePasswordController
                                        .oldPasswordController.value,
                                    currentFocusNode: changePasswordController
                                        .oldPasswordFocusNode.value,
                                    nextFocusNode: changePasswordController
                                        .newPasswordFocusNode.value,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "old_password_hint".tr;
                                      }
                                      if (value.length < 4) {
                                        return "password_length".tr;
                                      }
                                      return null;
                                    },
                                    prefixIcon: const Icon(Icons.lock),
                                  )),
                              SizedBox(height: mq.height * 0.05),
                              Obx(() => InputField(
                                    obscure: _isPasswordObscured.value,
                                    hintText: 'new_password_hint'.tr,
                                    labelText: 'new_password_hint'.tr,
                                    controller: changePasswordController
                                        .newPasswordController.value,
                                    currentFocusNode: changePasswordController
                                        .newPasswordFocusNode.value,
                                    nextFocusNode: changePasswordController
                                        .oldPasswordFocusNode.value,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "new_password_hint".tr;
                                      }
                                      if (value.length < 4) {
                                        return "password_length".tr;
                                      }
                                      return null;
                                    },
                                    prefixIcon: const Icon(Icons.lock),
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          _isPasswordObscured.value =
                                              !_isPasswordObscured.value;
                                        },
                                        icon: _isPasswordObscured.value
                                            ? const Icon(Icons.visibility_off)
                                            : const Icon(Icons.visibility)),
                                  )),
                              SizedBox(height: mq.height * 0.05),
                              Obx(() => RoundBtn(
                                    loading: changePasswordController
                                        .loading.value,
                                    title: "change_password".tr,
                                    width: isWideScreen
                                        ? mq.width * 0.15
                                        : mq.width * 0.5,
                                    onPress: () {
                                      if (_passwordKey.currentState!
                                          .validate()) {
                                        changePasswordController
                                            .changePassword();
                                      }
                                    },
                                  )),
                              SizedBox(height: mq.height * 0.05),
                              TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text(
                                  "back_to_login".tr,
                                  style: TextStyle(
                                    fontSize: isWideScreen
                                        ? mq.width * 0.015
                                        : mq.height * 0.03,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
