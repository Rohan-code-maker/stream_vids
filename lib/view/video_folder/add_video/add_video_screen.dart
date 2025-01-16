import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stream_vids/res/components/input_field.dart';
import 'package:stream_vids/res/components/round_btn.dart';
import 'package:stream_vids/view_models/controller/video_folder/add_video/add_video_controller.dart';
import 'package:lottie/lottie.dart';

class AddVideoScreen extends StatefulWidget {
  const AddVideoScreen({super.key});

  @override
  State<AddVideoScreen> createState() => _AddVideoScreenState();
}

class _AddVideoScreenState extends State<AddVideoScreen> {
  final _controller = Get.put(AddVideoController());
  final _addVideoKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text('post_video'.tr),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWideScreen = constraints.maxWidth > 600;
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Container(
                  width: isWideScreen ? mq.width * 0.5 : mq.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    border: Border.all(
                        width: 2,
                        color: isDarkMode ? Colors.white : Colors.black),
                  ),
                  child: Form(
                    key: _addVideoKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: mq.height * 0.3,
                          child: Lottie.asset(
                            'assets/animation/video_upload_animation.json',
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(height: mq.height * 0.1),
                        SizedBox(
                          width: isWideScreen ? mq.width * 0.3 : mq.width * 0.8,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Obx(
                                () => InputField(
                                  hintText: 'title_hint'.tr,
                                  labelText: 'title_hint'.tr,
                                  controller: _controller.titleController.value,
                                  currentFocusNode:
                                      _controller.titleFocusNode.value,
                                  nextFocusNode:
                                      _controller.descriptionFocusNode.value,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'title_hint'.tr;
                                    }
                                    return null;
                                  },
                                  prefixIcon: const Icon(Icons.title),
                                ),
                              ),
                              SizedBox(height: mq.height * 0.05),
                              Obx(
                                () => InputField(
                                  hintText: 'description_hint'.tr,
                                  labelText: 'description_hint'.tr,
                                  controller:
                                      _controller.descriptionController.value,
                                  currentFocusNode:
                                      _controller.descriptionFocusNode.value,
                                  nextFocusNode:
                                      _controller.titleFocusNode.value,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'description_hint'.tr;
                                    }
                                    return null;
                                  },
                                  prefixIcon: const Icon(Icons.description),
                                ),
                              ),
                              SizedBox(height: mq.height * 0.05),
                              Obx(()=>
                                TextFormField(
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                                    labelText: 'video_hint'.tr,
                                    hintText: 'video_hint'.tr,
                                    suffixIcon: IconButton(
                                      icon: const Icon(Icons.video_collection_outlined),
                                      onPressed: () => _controller.pickVideo(),
                                    ),
                                  ),
                                  controller: TextEditingController(
                                    text: _controller.videoName.value,
                                  ),
                                  validator: (value) {
                                    if (_controller.videoFile.value == null) {
                                      return 'select_video'.tr;
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(
                                height: mq.height * .05,
                              ),
                              Obx(()=>
                                 TextFormField(
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
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
                                    if (_controller.thumbnailImage.value ==
                                        null) {
                                      return 'select_photo'.tr;
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(height: mq.height * 0.05),
                              Obx(
                                () => RoundBtn(
                                  loading: _controller.loading.value,
                                  title: "post_video".tr,
                                  width: isWideScreen
                                      ? mq.width * 0.15
                                      : mq.width * 0.5,
                                  onPress: () {
                                    if (_addVideoKey.currentState!.validate()) {
                                      _controller.submitVideo();
                                    }
                                  },
                                ),
                              ),
                              SizedBox(
                                height: mq.height * 0.01,
                              )
                            ],
                          ),
                        )
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
