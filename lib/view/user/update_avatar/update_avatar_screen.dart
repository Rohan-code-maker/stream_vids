import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stream_vids/res/components/round_btn.dart';
import 'package:stream_vids/utils/utils.dart';
import 'package:stream_vids/view_models/controller/user/update_avatar/update_avatar_controller.dart';

class UpdateAvatarScreen extends StatefulWidget {
  const UpdateAvatarScreen({super.key});

  @override
  State<UpdateAvatarScreen> createState() => _UpdateAvatarScreenState();
}

class _UpdateAvatarScreenState extends State<UpdateAvatarScreen> {
  final _avatarKey = GlobalKey<FormState>();
  final _controller = Get.put(UpdateAvatarController());
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('update_avatar'.tr),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: Form(
        key: _avatarKey,
        child: Center(
          child: Column(
            children: [
              TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'avatar_hint'.tr,
                  hintText: 'avatar_hint'.tr,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.photo),
                    onPressed: () => _controller.pickImage(),
                  ),
                ),
                controller: TextEditingController(
                  text: _controller.avatarImageName.value,
                ),
                validator: (value) {
                  if (_controller.avatarImage.value == null) {
                    // Validate if avatar image is selected
                    Utils.toastMessageBottom("select_photo".tr);
                    return 'select_photo'.tr;
                  }
                  return null;
                },
              ),
              SizedBox(
                height: mq.height * .05,
              ),
              Obx(
                () => RoundBtn(
                    loading: _controller.loading.value,
                    title: "update".tr,
                    width: mq.width * .35,
                    onPress: () {
                      if (_avatarKey.currentState!.validate()) {
                        _controller.updateAvatar();
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
