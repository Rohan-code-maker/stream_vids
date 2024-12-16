import 'package:flutter/material.dart';
import 'package:stream_vids/res/colors/app_colors.dart';

class RoundBtn extends StatelessWidget {
  const RoundBtn(
      {super.key,
      this.loading = false,
      required this.title,
      this.height = 50,
      this.width = 60,
      this.textColor = AppColors.white,
      this.buttonColor = AppColors.primary,
      required this.onPress});

  final bool loading;
  final String title;
  final double height, width;
  final Color textColor, buttonColor;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: buttonColor,
        ),
        child: loading
            ? const Center(child: CircularProgressIndicator())
            : Center(
                child: Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: AppColors.white),
                ),
              ),
      ),
    );
  }
}
