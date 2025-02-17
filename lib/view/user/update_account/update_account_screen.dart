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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('update_account'.tr),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios)),
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
                    color: isDarkMode ? Colors.black : Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    border: Border.all(
                      width: 2,
                      color: Colors.black,
                    ),
                  ),
                  child: Form(
                    key: _updateKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: mq.height * 0.05,
                        ),
                        SizedBox(
                          width: isWideScreen ? mq.width * 0.3 : mq.width * 0.8,
                          child: Column(
                            children: [
                              Obx(
                                () => InputField(
                                  hintText: 'fullName_hint'.tr,
                                  labelText: 'fullName_hint'.tr,
                                  controller:
                                      controller.fullnameController.value,
                                  currentFocusNode:
                                      controller.fullnameFocusNode.value,
                                  nextFocusNode:
                                      controller.usernameFocusNode.value,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      Utils.toastMessageBottom(
                                          "fullName_hint".tr);
                                      return 'fullName_hint'.tr;
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(height: mq.height * 0.05),
                              Obx(
                                () => InputField(
                                  hintText: 'username_hint'.tr,
                                  labelText: 'username_hint'.tr,
                                  controller:
                                      controller.usernameController.value,
                                  currentFocusNode:
                                      controller.usernameFocusNode.value,
                                  nextFocusNode:
                                      controller.emailFocusNode.value,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      Utils.toastMessageBottom(
                                          "username_hint".tr);
                                      return 'username_hint'.tr;
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(height: mq.height * 0.05),
                              Obx(
                                () => InputField(
                                  hintText: 'email_hint'.tr,
                                  labelText: 'email_hint'.tr,
                                  controller: controller.emailController.value,
                                  currentFocusNode:
                                      controller.emailFocusNode.value,
                                  nextFocusNode:
                                      controller.fullnameFocusNode.value,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      Utils.toastMessageBottom("email_hint".tr);
                                      return 'email_hint'.tr;
                                    }
                                    if (!Utils.isValidEmail(controller
                                        .emailController.value.text)) {
                                      Utils.toastMessageBottom(
                                          "invalid_email".tr);
                                      return 'invalid_email'.tr;
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(height: mq.height * 0.05),
                              Obx(
                                () => RoundBtn(
                                  loading: controller.isLoading.value,
                                  title: "update".tr,
                                  width: isWideScreen
                                      ? mq.width * 0.15
                                      : mq.width * 0.5,
                                  onPress: () {
                                    if (_updateKey.currentState!.validate()) {
                                      controller.updateAccount();
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: mq.height * 0.05),
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
