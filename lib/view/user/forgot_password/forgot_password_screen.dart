import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
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
  final forgotPasswordController = Get.put(ForgotPasswordController());
  final _forgotPasswordKey = GlobalKey<FormState>();
  final RxBool _isPasswordObscured = true.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: true,
        title: Text(
          'forgot_password'.tr,
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWideScreen = constraints.maxWidth > 600;
          final mq = MediaQuery.of(context).size;

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
                      color:  Colors.black,
                    ),
                  ),
                  child: Form(
                    key: _forgotPasswordKey,
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
                                    hintText: 'email_hint'.tr,
                                    labelText: 'email_hint'.tr,
                                    controller: forgotPasswordController
                                        .emailController.value,
                                    currentFocusNode: forgotPasswordController
                                        .emailFocusNode.value,
                                    nextFocusNode: forgotPasswordController
                                        .usernameFocusNode.value,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "email_hint".tr;
                                      }
                                      if (!Utils.isValidEmail(value)) {
                                        return "invalid_email".tr;
                                      }
                                      return null;
                                    },
                                    prefixIcon: const Icon(Icons.email),
                                  )),
                              SizedBox(height: mq.height * 0.05),
                              Obx(() => InputField(
                                    hintText: 'username_hint'.tr,
                                    labelText: 'username_hint'.tr,
                                    controller: forgotPasswordController
                                        .usernameController.value,
                                    currentFocusNode: forgotPasswordController
                                        .usernameFocusNode.value,
                                    nextFocusNode: forgotPasswordController
                                        .newPasswordFocusNode.value,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "username_hint".tr;
                                      }
                                      return null;
                                    },
                                    prefixIcon: const Icon(Icons.person),
                                  )),
                              SizedBox(height: mq.height * 0.05),
                              Obx(
                                () => InputField(
                                  obscure: true,
                                  hintText: 'new_password_hint'.tr,
                                  labelText: 'new_password_hint'.tr,
                                  controller: forgotPasswordController
                                      .newPasswordController.value,
                                  currentFocusNode: forgotPasswordController
                                      .newPasswordFocusNode.value,
                                  nextFocusNode: forgotPasswordController
                                      .emailFocusNode.value,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "new_password_hint".tr;
                                    }
                                    if (value.length < 8) {
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
                                ),
                              ),
                              SizedBox(height: mq.height * 0.05),
                              Obx(() => RoundBtn(
                                    loading:
                                        forgotPasswordController.loading.value,
                                    title: "reset_password".tr,
                                    width: isWideScreen
                                        ? mq.width * 0.15
                                        : mq.width * 0.5,
                                    onPress: () {
                                      if (_forgotPasswordKey.currentState!
                                          .validate()) {
                                        forgotPasswordController
                                            .forgotPassword();
                                      }
                                    },
                                  )),
                              SizedBox(height: mq.height * 0.05),
                              TextButton(
                                onPressed: () {
                                  Get.back(); // Navigate back to Login Screen
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
