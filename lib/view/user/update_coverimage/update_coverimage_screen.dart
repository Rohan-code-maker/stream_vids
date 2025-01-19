import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stream_vids/res/components/round_btn.dart';
import 'package:stream_vids/view_models/controller/user/update_coverimage/update_coverimage_controller.dart';

class UpdateCoverImageScreen extends StatefulWidget {
  const UpdateCoverImageScreen({super.key});

  @override
  State<UpdateCoverImageScreen> createState() => _UpdateCoverImageScreenState();
}

class _UpdateCoverImageScreenState extends State<UpdateCoverImageScreen>
    with SingleTickerProviderStateMixin {
  final _coverKey = GlobalKey<FormState>();
  final _controller = Get.put(UpdateCoverimageController());

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize Animation Controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    // Define Fade Animation
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    // Start Animation
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('update_coverimage'.tr),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWideScreen = constraints.maxWidth > 600;

          return FadeTransition(
            opacity: _fadeAnimation,
            child: Form(
              key: _coverKey,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Center(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    height: isWideScreen ? mq.height * 0.6 : mq.width * 0.8,
                    width: isWideScreen ? mq.width * 0.5 : mq.width * 0.9,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 4,
                          blurRadius: 10,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Obx(
                      () => Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: mq.height * 0.05,
                          ),
                          RoundBtn(
                            loading: _controller.loading.value,
                            title: "update".tr,
                            width:
                                isWideScreen ? mq.width * 0.25 : mq.width * 0.6,
                            onPress: () {
                              if (_coverKey.currentState!.validate()) {
                                _controller.updateCoverImage();
                              }
                            },
                          ),
                          SizedBox(
                            height: mq.height * 0.02,
                          ),
                          _controller.coverImage.value != null
                              ? FadeTransition(
                                  opacity: _fadeAnimation,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.file(
                                      _controller.coverImage.value!,
                                      width: mq.width * 0.6,
                                      height: mq.height * 0.3,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ],
                      ),
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
