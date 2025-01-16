import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stream_vids/res/components/input_field.dart';
import 'package:stream_vids/res/components/round_btn.dart';
import 'package:stream_vids/utils/utils.dart';
import 'package:stream_vids/view_models/controller/user/update_account/update_account_controller.dart';

class UpdateAccountScreen extends StatefulWidget {
  const UpdateAccountScreen({super.key});

  @override
  State<UpdateAccountScreen> createState() => _UpdateAccountScreenState();
}

class _UpdateAccountScreenState extends State<UpdateAccountScreen> {
  UpdateAccountController controller = Get.put(UpdateAccountController());

  final _updateKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('update_account'.tr),
        centerTitle: true,
      ),
      body: Form(
        key: _updateKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InputField(
                hintText: 'fullName_hint'.tr,
                labelText: 'fullName_hint'.tr,
                controller: controller.fullnameController.value,
                currentFocusNode: controller.fullnameFocusNode.value,
                nextFocusNode: controller.usernameFocusNode.value,
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
                controller: controller.usernameController.value,
                currentFocusNode: controller.usernameFocusNode.value,
                nextFocusNode: controller.emailFocusNode.value,
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
                controller: controller.emailController.value,
                currentFocusNode: controller.emailFocusNode.value,
                nextFocusNode: controller.usernameFocusNode.value,
                validator: (value) {
                  if (value!.isEmpty) {
                    Utils.toastMessageBottom("email_hint".tr);
                    return 'email_hint'.tr;
                  }
                  if (!Utils.isValidEmail(
                      controller.emailController.value.text)) {
                    Utils.toastMessageBottom("invalid_email".tr);
                    return 'invalid_email'.tr;
                  }
                  return null;
                },
              ),
              SizedBox(
                height: mq.height * .1,
              ),
              Obx(() => RoundBtn(
                  loading: controller.isLoading.value,
                  title: "update".tr,
                  width: mq.width * .35,
                  onPress: () {
                    if (_updateKey.currentState!.validate()) {
                      controller.updateAccount();
                    }
                  })),
            ],
          ),
        ),
      ),
    );
  }
}
