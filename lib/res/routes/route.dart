import 'package:get/get.dart';
import 'package:stream_vids/res/routes/route_name.dart';
import 'package:stream_vids/view/forgot_password/forgot_password_screen.dart';
import 'package:stream_vids/view/home/home_screen.dart';
import 'package:stream_vids/view/language_screen.dart';
import 'package:stream_vids/view/login/login_screen.dart';
import 'package:stream_vids/view/register/register_screen.dart';
import 'package:stream_vids/view/splash_screen.dart';

class AppRoutes {
  static appRoutes() => [
    GetPage(name: RouteName.splashScreen, page: () => const SplashScreen(),
    transition: Transition.leftToRightWithFade,
    transitionDuration: const Duration(microseconds: 250)
    ),
    GetPage(name: RouteName.languageScreen, page: () => const LanguageScreen(),
    transition: Transition.leftToRightWithFade,
    transitionDuration: const Duration(microseconds: 250)
    ),
    GetPage(name: RouteName.loginScreen, page: () => const LoginScreen(),
    transition: Transition.leftToRightWithFade,
    transitionDuration: const Duration(microseconds: 250)
    ),
    GetPage(name: RouteName.registerScreen, page: () => const RegisterScreen(),
    transition: Transition.leftToRightWithFade,
    transitionDuration: const Duration(microseconds: 250)
    ),
    GetPage(name: RouteName.homeScreen, page: () => const HomeScreen(),
    transition: Transition.leftToRightWithFade,
    transitionDuration: const Duration(microseconds: 250)
    ),
    GetPage(name: RouteName.forgotPasswordScreen, page: () => const ForgotPasswordScreen(),
    transition: Transition.leftToRightWithFade,
    transitionDuration: const Duration(microseconds: 250)
    ),
  ];
}
