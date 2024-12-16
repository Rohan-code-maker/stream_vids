import 'package:flutter/material.dart';
import 'package:stream_vids/res/getx_localization/languages.dart';
import 'package:get/get.dart';
import 'package:stream_vids/res/routes/route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Stream Vids',
      debugShowCheckedModeBanner: false,
      translations: Languages(),
      locale: const Locale('en', 'US'),
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      getPages: AppRoutes.appRoutes(),
    );
  }
}