import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  var isDark = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadTheme(); // Load the saved theme preference when the controller initializes
  }

  ThemeMode get theme => isDark.value ? ThemeMode.dark : ThemeMode.light;

  void changeTheme() async {
    isDark.value = !isDark.value;
    Get.changeThemeMode(theme);
    saveTheme(isDark.value); // Save the preference
  }

  void saveTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', value);
  }

  void loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isDark.value = prefs.getBool('isDarkMode') ?? false; // Default to light mode if no value is saved
    Get.changeThemeMode(theme); // Apply the saved theme
  }
}