import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stream_vids/res/components/input_field.dart';
import 'package:stream_vids/res/components/round_btn.dart';
import 'package:stream_vids/res/routes/route_name.dart';
import 'package:stream_vids/utils/utils.dart';
import 'package:stream_vids/view_models/controller/user/login_controller/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginController = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    loginController.emailFocusNode.value.dispose();
    loginController.passwordFocusNode.value.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text('login_screen'.tr),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InputField(
                  hintText: 'email_hint'.tr,
                  labelText: 'email_hint'.tr,
                  controller: loginController.emailController.value,
                  currentFocusNode: loginController.emailFocusNode.value,
                  nextFocusNode: loginController.passwordFocusNode.value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "email_hint".tr;
                    }
                    if (!Utils.isValidEmail(value)) {
                      return "invalid_email".tr;
                    }
                    return null;
                  },
                ),
                SizedBox(height: mq.height * .1),
                InputField(
                  obscure: true,
                  hintText: 'password_hint'.tr,
                  labelText: 'password_hint'.tr,
                  controller: loginController.passwordController.value,
                  currentFocusNode: loginController.passwordFocusNode.value,
                  nextFocusNode: loginController.emailFocusNode.value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "password_hint".tr;
                    }
                    if (value.length < 4) {
                      return "password_length".tr;
                    }
                    return null;
                  },
                ),
                SizedBox(height: mq.height * .1),
                Obx(
                  () => RoundBtn(
                    loading: loginController.loading.value,
                    title: "login".tr,
                    width: mq.width * .35,
                    onPress: () {
                      if (_formKey.currentState!.validate()) {
                        loginController.login();
                      }
                    },
                  ),
                ),
                SizedBox(height: mq.height * .1),
                RoundBtn(
                  title: "register".tr,
                  width: mq.width * .35,
                  onPress: () {
                    Get.toNamed(RouteName.registerScreen);
                  },
                ),
                RoundBtn(
                  title: "forgot_password".tr,
                  width: mq.width * .35,
                  onPress: () {
                    Get.toNamed(RouteName.forgotPasswordScreen);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
