import 'package:flutter/material.dart';
import 'package:stream_vids/res/colors/app_colors.dart';

class RoundBtn extends StatelessWidget {
  const RoundBtn(
      {super.key,
      required this.loading,
      required this.title,
      required this.height,
      required this.width,
      required this.textColor,
      required this.buttonColor,
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
        ? const Center(child: CircularProgressIndicator()) : Center(
          child: Text(title,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.white),
          ),
        )

        ,
      ),
    );
  }
}
