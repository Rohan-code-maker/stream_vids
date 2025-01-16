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

class _LanguageScreenState extends State<LanguageScreen>
    with SingleTickerProviderStateMixin {
  final LanguageService _languageService = LanguageService();
  SplashServices splashServices = SplashServices();
  late AnimationController _animationController;
  late Animation<Offset> _buttonAnimation;

  @override
  void initState() {
    super.initState();
    _languageService.initializeLocale();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _buttonAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _changeLanguage(Locale locale) async {
    _languageService.setLocale(locale);
    Utils.snackBar('Language Selected',
        'App language is now set to ${locale.languageCode.toUpperCase()}');
    splashServices.handleAppNavigation();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final mq = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('choose_language'.tr),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        final isLargeScreen = constraints.maxWidth > 600;

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: SlideTransition(
              position: _buttonAnimation,
              child: Container(
                width: isLargeScreen ? mq.width * 0.5 : mq.width * 1,
                height: isLargeScreen ? mq.height * 0.5 : mq.height * 1,
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 1,
                      color: isDarkMode ? Colors.white : Colors.black),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildLanguageButton(
                      context,
                      'english'.tr,
                      const Locale('en', 'US'),
                      mq.width * 0.3,
                      isDarkMode,
                    ),
                    const SizedBox(height: 16),
                    _buildLanguageButton(
                      context,
                      'hindi'.tr,
                      const Locale('hi', 'IN'),
                      mq.width * 0.3,
                      isDarkMode,
                    ),
                    const SizedBox(height: 16),
                    _buildLanguageButton(
                      context,
                      'nepali'.tr,
                      const Locale('ne', 'NP'),
                      mq.width * 0.3,
                      isDarkMode,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildLanguageButton(BuildContext context, String text, Locale locale,
      double width, bool isDarkMode) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: isDarkMode
              ? Colors.grey[800]
              : Colors.blue, // Adaptive color for light/dark modes
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 5,
        ),
        onPressed: () => _changeLanguage(locale),
        child: Text(
          text,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
