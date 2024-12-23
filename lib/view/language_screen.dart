import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stream_vids/utils/utils.dart';
import 'package:stream_vids/view_models/services/language_service.dart';
import 'package:stream_vids/view_models/services/splash_services.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  final LanguageService _languageService = LanguageService();
  final SplashServices _splashServices = SplashServices();

  @override
  void initState() {
    super.initState();
    _languageService.initializeLocale();
  }

  void _changeLanguage(Locale locale) {
    _languageService.setLocale(locale);
    Utils.snackBar('Language Selected',
        'App language is now set to ${locale.languageCode.toUpperCase()}');
    _splashServices.handleAppNavigation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('choose_language'.tr),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _changeLanguage(const Locale('en', 'US')),
              child: Text('english'.tr),
            ),
            ElevatedButton(
              onPressed: () => _changeLanguage(const Locale('hi', 'IN')),
              child: Text('hindi'.tr),
            ),
            ElevatedButton(
              onPressed: () => _changeLanguage(const Locale('ne', 'NP')),
              child: Text('nepali'.tr),
            ),
          ],
        ),
      ),
    );
  }
}
