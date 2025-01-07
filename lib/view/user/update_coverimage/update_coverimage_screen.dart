import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stream_vids/res/components/round_btn.dart';
import 'package:stream_vids/utils/utils.dart';
import 'package:stream_vids/view_models/controller/user/update_coverimage/update_coverimage_controller.dart';

class UpdateCoverimageScreen extends StatefulWidget {
  const UpdateCoverimageScreen({super.key});

  @override
  State<UpdateCoverimageScreen> createState() => _UpdateCoverimageScreenState();
}

class _UpdateCoverimageScreenState extends State<UpdateCoverimageScreen> {
  final _formKey = GlobalKey<FormState>();
  final _controller = Get.put(UpdateCoverimageController());
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('update_coverimage'.tr),
      ),
      body: Form(
          key: _formKey,
          child: Center(
            child: Obx(
              () => Column(
                children: [
                  TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'coverImage_hint'.tr,
                      hintText: 'coverImage_hint'.tr,
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.photo),
                        onPressed: () => _controller.pickImage(),
                      ),
                    ),
                    controller: TextEditingController(
                      text: _controller.coverImageName.value,
                    ),
                    validator: (value) {
                      if (_controller.coverImage.value == null) {
                        // Validate if avatar image is selected
                        Utils.toastMessageBottom("select_photo".tr);
                        return "select_photo".tr;
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: mq.height * .05,
                  ),
                  RoundBtn(
                      loading: _controller.loading.value,
                      title: "update".tr,
                      width: mq.width * .35,
                      onPress: () {
                        if (_formKey.currentState!.validate()) {
                          _controller.updateCoverImage();
                        }
                      })
                ],
              ),
            ),
          ),
        ),
    );
  }
}