import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stream_vids/res/components/input_field.dart';
import 'package:stream_vids/res/components/round_btn.dart';
import 'package:stream_vids/utils/utils.dart';
import 'package:stream_vids/view_models/controller/video_folder/update_video/update_video_controller.dart';

class UpdateVideoScreen extends StatefulWidget {
  final String videoId;
  const UpdateVideoScreen({super.key, required this.videoId});

  @override
  State<UpdateVideoScreen> createState() => _UpdateVideoScreenState();
}

class _UpdateVideoScreenState extends State<UpdateVideoScreen> {
  final GlobalKey<FormState> _videoKey = GlobalKey<FormState>();
  final _controller = Get.put(UpdateVideoController());

  @override
  void initState() {
    super.initState();

    final video = Get.arguments;

    if (video != null) {
      _controller.setVideoData(video);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('update_video'.tr),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: Form(
        key: _videoKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Obx(
            () => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InputField(
                  hintText: 'title_hint'.tr,
                  labelText: 'title_hint'.tr,
                  controller: _controller.titleController.value,
                  currentFocusNode: _controller.titleFocusNode.value,
                  nextFocusNode: _controller.descriptionFocusNode.value,
                  validator: (value) {
                    if (value!.isEmpty) {
                      Utils.toastMessageBottom("title_hint".tr);
                      return "title_hint".tr;
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: mq.height * .05,
                ),
                InputField(
                  hintText: 'description_hint'.tr,
                  labelText: 'description_hint'.tr,
                  controller: _controller.descriptionController.value,
                  currentFocusNode: _controller.descriptionFocusNode.value,
                  nextFocusNode: _controller.titleFocusNode.value,
                  validator: (value) {
                    if (value!.isEmpty) {
                      Utils.toastMessageBottom("description_hint".tr);
                      return "description_hint".tr;
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
                    labelText: 'video_hint'.tr,
                    hintText: 'video_hint'.tr,
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.photo),
                      onPressed: () => _controller.pickVideo(),
                    ),
                  ),
                  controller: TextEditingController(
                    text: _controller.videoName.value,
                  ),
                  validator: (value) {
                    if (_controller.videoFile.value == null) {
                      Utils.toastMessageBottom("select_video".tr);
                      return "select_video".tr;
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
                    labelText: 'thumbnail_hint'.tr,
                    hintText: 'thumbnail_hint'.tr,
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.photo),
                      onPressed: () => _controller.pickImage(),
                    ),
                  ),
                  controller: TextEditingController(
                    text: _controller.thumbnailImageName.value,
                  ),
                  validator: (value) {
                    if (_controller.thumbnailImage.value == null) {
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
                  title: "post_video".tr,
                  width: mq.width * .35,
                  onPress: () {
                    if (_videoKey.currentState!.validate()) {
                      _controller.updateVideo(widget.videoId);
                    }
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
