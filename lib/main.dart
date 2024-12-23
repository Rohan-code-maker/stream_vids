import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stream_vids/res/getx_localization/languages.dart';
import 'package:stream_vids/res/routes/route.dart';
import 'package:stream_vids/view_models/services/language_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure bindings are initialized for async calls

  // Initialize LanguageService to get saved locale
  final LanguageService languageService = LanguageService();
  Locale initialLocale = await languageService.getSavedLocale();

  runApp(MyApp(initialLocale: initialLocale));
}

class MyApp extends StatelessWidget {
  final Locale initialLocale;

  const MyApp({super.key, required this.initialLocale});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Stream Vids',
      debugShowCheckedModeBanner: false,
      translations: Languages(),
      locale: initialLocale,
      fallbackLocale: initialLocale,
      theme: ThemeData(primarySwatch: Colors.blue),
      getPages: AppRoutes.appRoutes(),
    );
  }
}
