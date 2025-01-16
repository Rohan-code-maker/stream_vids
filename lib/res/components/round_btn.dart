import 'package:flutter/material.dart';

class RoundBtn extends StatelessWidget {
  const RoundBtn({
    super.key,
    this.loading = false,
    required this.title,
    this.height = 50,
    this.width = 60,
    this.textColor = Colors.white,
    required this.onPress,
  });

  final bool loading;
  final String title;
  final double height, width;
  final Color textColor;
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
          gradient: const LinearGradient(
            colors: [
              Color(0xFF833AB4), // Purple
              Color(0xFFFD1D1D), // Red
              Color(0xFFFBAA47), // Yellow
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: loading
            ? const Center(child: CircularProgressIndicator())
            : Center(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: textColor), // Use the specified text color
                ),
              ),
      ),
    );
  }
}
