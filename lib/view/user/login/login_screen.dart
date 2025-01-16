import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stream_vids/res/components/input_field.dart';
import 'package:stream_vids/res/components/round_btn.dart';
import 'package:stream_vids/res/routes/route_name.dart';
import 'package:stream_vids/utils/utils.dart';
import 'package:stream_vids/view_models/controller/user/login_controller/login_controller.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginController = Get.put(LoginController());
  final _loginKey = GlobalKey<FormState>();
  final RxBool _isPasswordObscured = true.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          'login_screen'.tr,
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWideScreen = constraints.maxWidth > 600;
          final mq = MediaQuery.of(context).size;
          final isDarkMode = Theme.of(context).brightness == Brightness.dark;

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
                        color: isDarkMode ? Colors.white : Colors.black),
                  ),
                  child: Form(
                    key: _loginKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: mq.height * 0.3,
                          child: Lottie.asset(
                            'assets/animation/login_animation.json',
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
                              Obx(() =>
                                 InputField(
                                  hintText: 'email_hint'.tr,
                                  labelText: 'email_hint'.tr,
                                  controller:
                                      loginController.emailController.value,
                                  currentFocusNode:
                                      loginController.emailFocusNode.value,
                                  nextFocusNode:
                                      loginController.passwordFocusNode.value,
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
                                ),
                              ),
                              SizedBox(height: mq.height * 0.05),
                              Obx(
                                () => InputField(
                                  obscure: _isPasswordObscured.value,
                                  hintText: 'password_hint'.tr,
                                  labelText: 'password_hint'.tr,
                                  controller:
                                      loginController.passwordController.value,
                                  currentFocusNode:
                                      loginController.passwordFocusNode.value,
                                  nextFocusNode:
                                      loginController.emailFocusNode.value,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "password_hint".tr;
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
                                ),
                              ),
                              SizedBox(height: mq.height * 0.05),
                              Obx(
                                () => RoundBtn(
                                  loading: loginController.loading.value,
                                  title: "login".tr,
                                  width: isWideScreen
                                      ? mq.width * 0.15
                                      : mq.width * 0.5,
                                  onPress: () {
                                    if (_loginKey.currentState!.validate()) {
                                      loginController.login();
                                    }
                                  },
                                ),
                              ),
                              SizedBox(height: mq.height * 0.05),
                              RoundBtn(
                                title: "register".tr,
                                width: isWideScreen
                                    ? mq.width * 0.15
                                    : mq.width * 0.5,
                                onPress: () {
                                  Get.toNamed(RouteName.registerScreen);
                                },
                              ),
                              SizedBox(height: mq.height * 0.05),
                              TextButton(
                                onPressed: () {
                                  Get.toNamed(RouteName.forgotPasswordScreen);
                                },
                                child: Text(
                                  "forgot_password".tr,
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
