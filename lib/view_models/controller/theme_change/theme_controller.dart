import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  var isDark = false.obs;

  ThemeMode get theme => isDark.value ? ThemeMode.dark : ThemeMode.light;

  void changeTheme() {
    isDark.value = !isDark.value;
    Get.changeThemeMode(theme);
  }
}
