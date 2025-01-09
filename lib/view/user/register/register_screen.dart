import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stream_vids/res/components/input_field.dart';
import 'package:stream_vids/res/components/round_btn.dart';
import 'package:stream_vids/utils/utils.dart';
import 'package:stream_vids/view_models/controller/user/register_controller/register_controller.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final registerController = Get.put(RegisterController());

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('register_screen'.tr),
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
                hintText: 'fullName_hint'.tr,
                labelText: 'fullName_hint'.tr,
                controller: registerController.fullnameController.value,
                currentFocusNode: registerController.fullnameFocusNode.value,
                nextFocusNode: registerController.usernameFocusNode.value,
                validator: (value) {
                  if (value!.isEmpty) {
                    Utils.toastMessageBottom("fullName_hint".tr);
                    return 'fullName_hint'.tr;
                  }
                  return null;
                },
              ),
              SizedBox(
                height: mq.height * .05,
              ),
              InputField(
                hintText: 'username_hint'.tr,
                labelText: 'username_hint'.tr,
                controller: registerController.usernameController.value,
                currentFocusNode: registerController.usernameFocusNode.value,
                nextFocusNode: registerController.emailFocusNode.value,
                validator: (value) {
                  if (value!.isEmpty) {
                    Utils.toastMessageBottom("username_hint".tr);
                    return 'username_hint'.tr;
                  }
                  return null;
                },
              ),
              SizedBox(
                height: mq.height * .05,
              ),
              InputField(
                hintText: 'email_hint'.tr,
                labelText: 'email_hint'.tr,
                controller: registerController.emailController.value,
                currentFocusNode: registerController.emailFocusNode.value,
                nextFocusNode: registerController.passwordFocusNode.value,
                validator: (value) {
                  if (value!.isEmpty) {
                    Utils.toastMessageBottom("email_hint".tr);
                    return 'email_hint'.tr;
                  }
                  if (!Utils.isValidEmail(
                      registerController.emailController.value.text)) {
                    Utils.toastMessageBottom("invalid_email".tr);
                    return 'invalid_email'.tr;
                  }
                  return null;
                },
              ),
              SizedBox(
                height: mq.height * .05,
              ),
              InputField(
                obscure: true,
                hintText: 'password_hint'.tr,
                labelText: 'password_hint'.tr,
                controller: registerController.passwordController.value,
                currentFocusNode: registerController.passwordFocusNode.value,
                nextFocusNode: registerController.fullnameFocusNode.value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    Utils.toastMessageBottom("password_hint".tr);
                    return "password_hint".tr;
                  }
                  if (value.length < 4) {
                    Utils.toastMessageBottom("password_length".tr);
                    return "password_length".tr;
                  }
                  return null;
                },
              ),
              SizedBox(
                height: mq.height * .05,
              ),
              TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'avatar_hint'.tr,
                  hintText: 'avatar_hint'.tr,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.photo),
                    onPressed: () =>
                        registerController.pickImage(isAvatar: true),
                  ),
                ),
                controller: TextEditingController(
                  text: registerController.avatarImageName.value,
                ),
                validator: (value) {
                  if (registerController.avatarImage.value == null) {
                    Utils.toastMessageBottom("select_photo".tr);
                    return "select_photo".tr;
                  }
                  return null;
                },
              ),
              SizedBox(
                height: mq.height * .05,
              ),
              TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'coverImage_hint'.tr,
                  hintText: 'coverImage_hint'.tr,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.photo),
                    onPressed: () =>
                        registerController.pickImage(isAvatar: false),
                  ),
                ),
                controller: TextEditingController(
                  text: registerController.coverImageName.isNotEmpty
                      ? registerController.coverImageName.value
                      : '',
                ),
              ),
              SizedBox(
                height: mq.height * .05,
              ),
              Obx(
                () => RoundBtn(
                    loading: registerController.loading.value,
                    title: "register".tr,
                    width: mq.width * .35,
                    onPress: () {
                      if (_formKey.currentState!.validate()) {
                        registerController.register();
                      }
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
