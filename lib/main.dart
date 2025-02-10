import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stream_vids/res/getx_localization/languages.dart';
import 'package:stream_vids/res/routes/route.dart';
import 'package:stream_vids/view_models/controller/theme_change/theme_controller.dart';
import 'package:stream_vids/view_models/services/language_service.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure bindings are initialized for async calls

  // Initialize LanguageService to get saved locale
  final LanguageService languageService = LanguageService();
  Locale initialLocale = await languageService.getSavedLocale();
  // ignore: unused_local_variable
  final ThemeController themeController = Get.put(ThemeController());

  runApp(MyApp(initialLocale: initialLocale));
}

class MyApp extends StatelessWidget {
  final Locale initialLocale;

  const MyApp({super.key, required this.initialLocale});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();
    return Obx(
      () => GetMaterialApp(
        title: 'Stream Vids',
        debugShowCheckedModeBanner: false,
        translations: Languages(),
        locale: initialLocale,
        fallbackLocale: initialLocale,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(backgroundColor: Color(0xFFFFF8E1)),
          scaffoldBackgroundColor: const Color(0xFFFFF8E1),
          textTheme: const TextTheme(
            bodyLarge: TextStyle(color: Colors.black),
            bodyMedium: TextStyle(color: Colors.black),
          ),
        ),
        darkTheme: ThemeData.dark(),
        themeMode: themeController.theme,
        getPages: AppRoutes.appRoutes(),
      ),
    );
  }
}
