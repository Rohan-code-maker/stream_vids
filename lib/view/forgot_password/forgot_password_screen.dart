import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stream_vids/res/components/input_field.dart';
import 'package:stream_vids/res/components/round_btn.dart';
import 'package:stream_vids/utils/utils.dart';
import 'package:stream_vids/view_models/controller/change_password_controller/change_password_controller.dart';
import 'package:stream_vids/view_models/services/splash_services.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  SplashServices splashServices = SplashServices();
  ChangePasswordController changePasswordController = Get.put(ChangePasswordController());
  @override
  void initState() {
    super.initState();
    splashServices.handleAppNavigation();
  }

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
                obscure: true,
                hintText: 'old_password_hint'.tr,
                labelText: 'old_password_hint'.tr,
                controller: changePasswordController.oldPasswordController.value,
                currentFocusNode: changePasswordController.oldPasswordFocusNode.value,
                nextFocusNode: changePasswordController.newPasswordFocusNode.value,
                validator: (value) {
                  if (value!.isEmpty) {
                    Utils.toastMessageBottom("old_password_hint".tr);
                  }
                  if (value.length < 8) {
                    Utils.toastMessageBottom("old_password_hint".tr);
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
                controller: changePasswordController.newPasswordController.value,
                currentFocusNode: changePasswordController.newPasswordFocusNode.value,
                nextFocusNode: changePasswordController.oldPasswordFocusNode.value,
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
                  loading: changePasswordController.loading.value,
                  title: "login".tr,
                  width: mq.width * .35,
                  onPress: () {
                    if (_formKey.currentState!.validate()) {
                      changePasswordController.changePassword();
                    }
                  })),
                ],
              ),
            ),
          )),
    );
  }
}
