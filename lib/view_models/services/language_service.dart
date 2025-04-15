import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageService {
  static const String languageKey = 'selectedLanguage';

  Future<void> setLocale(Locale locale) async {
    Get.updateLocale(locale);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(languageKey, locale.languageCode);
  }

  Future<Locale> getSavedLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? languageCode = prefs.getString(languageKey);

    switch (languageCode) {
      case 'hi':
        return const Locale('hi', 'IN');
      case 'ne':
        return const Locale('ne', 'NP');
      case 'gu':
        return const Locale('gu', 'IN');
      default:
        return const Locale('en', 'US'); // Default language
    }
  }

  Future<void> initializeLocale() async {
    Locale savedLocale = await getSavedLocale();
    Get.updateLocale(savedLocale);
  }
}
