import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stream_vids/res/components/input_field.dart';
import 'package:stream_vids/res/components/round_btn.dart';
import 'package:stream_vids/utils/utils.dart';
import 'package:stream_vids/view_models/controller/login_controller/login_controller.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final loginController = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('login_screen'.tr),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
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
                  if (value!.isEmpty) {
                    Utils.toastMessageBottom("email_hint".tr);
                  }
                  if (!Utils.isValidEmail(
                      loginController.emailController.value.text)) {
                    Utils.toastMessageBottom("invalid_email".tr);
                  }
                  return null;
                },
              ),
              SizedBox(
                height: mq.height * .15,
              ),
              InputField(
                obscure: true,
                hintText: 'password_hint'.tr,
                labelText: 'password_hint'.tr,
                controller: loginController.passwordController.value,
                currentFocusNode: loginController.passwordFocusNode.value,
                nextFocusNode: loginController.emailFocusNode.value,
                validator: (value) {
                  if (value!.isEmpty) {
                    Utils.toastMessageBottom("password_hint".tr);
                  }
                  if (value.length < 8) {
                    Utils.toastMessageBottom("password_length".tr);
                  }
                  return null;
                },
              ),
              SizedBox(
                height: mq.height * .15,
              ),
              Obx(() => RoundBtn(
                  loading: loginController.loading.value,
                  title: "login".tr,
                  width: mq.width * .35,
                  onPress: () {
                    if (_formKey.currentState!.validate()) {
                      loginController.login();
                    }
                  }))
            ],
          ),
        ),
      ),
    );
  }
}
