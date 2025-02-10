import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:stream_vids/res/colors/app_colors.dart';
import 'package:timeago/timeago.dart' as timeago;

class Utils {
  static void fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static toastMessageBottom(String message) {
    Fluttertoast.showToast(
        msg: message,
        backgroundColor: AppColors.black,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG);
  }

  static toastMessageCenter(String message) {
    Fluttertoast.showToast(
        msg: message,
        backgroundColor: AppColors.black,
        gravity: ToastGravity.CENTER,
        toastLength: Toast.LENGTH_SHORT);
  }

  static snackBar(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors.black,
      colorText: AppColors.white,
    );
  }

  static bool isValidEmail(String email) {
    // Regular expression for email validation
    const emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    final regex = RegExp(emailPattern);
    return regex.hasMatch(email);
  }

  static void showConfirmation({
    required BuildContext context,
    required String title,
    required String message,
    required VoidCallback onConfirm,
  }) {
    Get.dialog(
      AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              // Close the dialog
              Get.back();
            },
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              // Perform the confirm action
              Get.back(); // Close the dialog first
              onConfirm(); // Call the passed callback function
            },
            child: const Text("Confirm"),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  static String extractErrorMessage(String html) {
    // Regular expression to capture error message between "Error: " and "<br>"
    final RegExp regExp = RegExp(r'Error:\s(.*?)<br>');
    final match = regExp.firstMatch(html);
    if (match != null) {
      return match.group(1) ?? "Unknown error occurred.";
    }
    return "Unknown error occurred.";
  }

  static String timeAgo(String timestamp) {
  DateTime dateTime = DateTime.parse(timestamp);
  return timeago.format(dateTime, locale: 'en'); // You can change locale if needed
}
}
