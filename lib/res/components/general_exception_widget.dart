import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stream_vids/res/colors/app_colors.dart';

class GeneralExceptionWidget extends StatefulWidget {
  final VoidCallback onPress;
  const GeneralExceptionWidget({super.key, required this.onPress});

  @override
  State<GeneralExceptionWidget> createState() => _GeneralExceptionWidgetState();
}

class _GeneralExceptionWidgetState extends State<GeneralExceptionWidget> {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SizedBox(
            height: mq.height * .15,
          ),
          Icon(
            Icons.cloud_off,
            color: AppColors.red,
            size: mq.width * .15,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Center(
              child: Text(
                Get.locale == null
                    ? 'general_exception'
                    : 'general_exception'.tr,
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.red),
              ),
            ),
          ),
          SizedBox(
            height: mq.height * .15,
          ),
          InkWell(
            onTap: widget.onPress,
            child: Container(
              height: mq.height * .1,
              decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(50)),
              child: Center(
                child: Text(
                  Get.locale == null ? 'retry' : 'retry'.tr,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: AppColors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
