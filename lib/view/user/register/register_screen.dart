import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stream_vids/res/components/input_field.dart';
import 'package:stream_vids/res/components/round_btn.dart';
import 'package:stream_vids/utils/utils.dart';
import 'package:stream_vids/view_models/controller/user/register_controller/register_controller.dart';
import 'package:lottie/lottie.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final registerController = Get.put(RegisterController());
  final _registerKey = GlobalKey<FormState>();
  final RxBool _isPasswordObscured = true.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'register_screen'.tr,
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
                    key: _registerKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: mq.height * 0.3,
                          child: Lottie.asset(
                            'assets/animation/register_animation.json',
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
                              Obx(
                                () => InputField(
                                  hintText: 'fullName_hint'.tr,
                                  labelText: 'fullName_hint'.tr,
                                  controller: registerController
                                      .fullnameController.value,
                                  currentFocusNode: registerController
                                      .fullnameFocusNode.value,
                                  nextFocusNode: registerController
                                      .usernameFocusNode.value,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'fullName_hint'.tr;
                                    }
                                    return null;
                                  },
                                  prefixIcon: const Icon(Icons.person),
                                ),
                              ),
                              SizedBox(height: mq.height * 0.05),
                              Obx(
                                () => InputField(
                                  hintText: 'username_hint'.tr,
                                  labelText: 'username_hint'.tr,
                                  controller: registerController
                                      .usernameController.value,
                                  currentFocusNode: registerController
                                      .usernameFocusNode.value,
                                  nextFocusNode:
                                      registerController.emailFocusNode.value,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'username_hint'.tr;
                                    }
                                    return null;
                                  },
                                  prefixIcon: const Icon(Icons.account_circle),
                                ),
                              ),
                              SizedBox(height: mq.height * 0.05),
                              Obx(
                                () => InputField(
                                  hintText: 'email_hint'.tr,
                                  labelText: 'email_hint'.tr,
                                  controller:
                                      registerController.emailController.value,
                                  currentFocusNode:
                                      registerController.emailFocusNode.value,
                                  nextFocusNode: registerController
                                      .passwordFocusNode.value,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'email_hint'.tr;
                                    }
                                    if (!Utils.isValidEmail(value)) {
                                      return 'invalid_email'.tr;
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
                                  controller: registerController
                                      .passwordController.value,
                                  currentFocusNode: registerController
                                      .passwordFocusNode.value,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'password_hint'.tr;
                                    }
                                    if (value.length < 4) {
                                      return 'password_length'.tr;
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
                                        : const Icon(Icons.visibility),
                                  ),
                                  nextFocusNode: registerController
                                      .fullnameFocusNode.value,
                                ),
                              ),
                              SizedBox(height: mq.height * 0.05),
                              Obx(
                                () => TextFormField(
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0)),
                                    labelText: 'avatar_hint'.tr,
                                    hintText: 'avatar_hint'.tr,
                                    suffixIcon: IconButton(
                                      icon: const Icon(Icons.photo),
                                      onPressed: () => registerController
                                          .pickImage(isAvatar: true),
                                    ),
                                  ),
                                  controller: TextEditingController(
                                    text: registerController
                                        .avatarImageName.value,
                                  ),
                                  validator: (value) {
                                    if (registerController.avatarImage.value ==
                                        null) {
                                      Utils.toastMessageBottom(
                                          "select_photo".tr);
                                      return "select_photo".tr;
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(
                                height: mq.height * .05,
                              ),
                              Obx(
                                () => TextFormField(
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0)),
                                    labelText: 'coverImage_hint'.tr,
                                    hintText: 'coverImage_hint'.tr,
                                    suffixIcon: IconButton(
                                      icon: const Icon(Icons.photo),
                                      onPressed: () => registerController
                                          .pickImage(isAvatar: false),
                                    ),
                                  ),
                                  controller: TextEditingController(
                                    text: registerController
                                            .coverImageName.isNotEmpty
                                        ? registerController
                                            .coverImageName.value
                                        : '',
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: mq.height * .05,
                              ),
                              Obx(
                                () => RoundBtn(
                                  loading: registerController.loading.value,
                                  title: "register".tr,
                                  width: isWideScreen
                                      ? mq.width * 0.15
                                      : mq.width * 0.5,
                                  onPress: () {
                                    if (_registerKey.currentState!.validate()) {
                                      registerController.register();
                                    }
                                  },
                                ),
                              ),
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
