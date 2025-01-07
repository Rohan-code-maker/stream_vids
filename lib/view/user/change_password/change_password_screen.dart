import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stream_vids/res/components/input_field.dart';
import 'package:stream_vids/res/components/round_btn.dart';
import 'package:stream_vids/utils/utils.dart';
import 'package:stream_vids/view_models/controller/user/change_password_controller/change_password_controller.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  ChangePasswordController changePasswordController =
      Get.put(ChangePasswordController());

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('change_password'.tr),
      ),
      body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Center(
              child: Obx(
                () => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InputField(
                      obscure: true,
                      hintText: 'old_password_hint'.tr,
                      labelText: 'old_password_hint'.tr,
                      controller:
                          changePasswordController.oldPasswordController.value,
                      currentFocusNode:
                          changePasswordController.oldPasswordFocusNode.value,
                      nextFocusNode:
                          changePasswordController.newPasswordFocusNode.value,
                      validator: (value) {
                        if (value!.isEmpty) {
                          Utils.toastMessageBottom("old_password_hint".tr);
                          return 'old_password_hint'.tr;
                        }
                        if (value.length < 8) {
                          Utils.toastMessageBottom("old_password_hint".tr);
                          return 'password_length'.tr;
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
                          changePasswordController.newPasswordController.value,
                      currentFocusNode:
                          changePasswordController.newPasswordFocusNode.value,
                      nextFocusNode:
                          changePasswordController.oldPasswordFocusNode.value,
                      validator: (value) {
                        if (value!.isEmpty) {
                          Utils.toastMessageBottom("new_password_hint".tr);
                          return 'new_password_hint'.tr;
                        }
                        if (value.length < 8) {
                          Utils.toastMessageBottom("new_password_hint".tr);
                          return 'password_length'.tr;
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: mq.height * .1,
                    ),
                    RoundBtn(
                        loading: changePasswordController.loading.value,
                        title: "change_password".tr,
                        width: mq.width * .35,
                        onPress: () {
                          if (_formKey.currentState!.validate()) {
                            changePasswordController.changePassword();
                          }
                        }),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
