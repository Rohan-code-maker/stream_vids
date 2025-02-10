import 'package:get/get.dart';
import 'package:stream_vids/res/routes/route_name.dart';
import 'package:stream_vids/utils/auth_middleware.dart';
import 'package:stream_vids/view/bottom_navbar/bottom_navbar_screen.dart';
import 'package:stream_vids/view/user/change_password/change_password_screen.dart';
import 'package:stream_vids/view/user/forgot_password/forgot_password_screen.dart';
import 'package:stream_vids/view/user/profile/profile_screen.dart';
import 'package:stream_vids/view/user/update_account/update_account_screen.dart';
import 'package:stream_vids/view/user/update_avatar/update_avatar_screen.dart';
import 'package:stream_vids/view/user/update_coverimage/update_coverimage_screen.dart';
import 'package:stream_vids/view/user/user_screen/user_screen.dart';
import 'package:stream_vids/view/user/watch_history/watch_history_screen.dart';
import 'package:stream_vids/view/video_folder/home/home_screen.dart';
import 'package:stream_vids/view/language_screen.dart';
import 'package:stream_vids/view/user/login/login_screen.dart';
import 'package:stream_vids/view/user/register/register_screen.dart';
import 'package:stream_vids/view/splash_screen.dart';
import 'package:stream_vids/view/video_folder/liked_videos/liked_video_screen.dart';
import 'package:stream_vids/view/video_folder/update_video/update_video_screen.dart';
import 'package:stream_vids/view/video_folder/video/video_screen.dart';

class AppRoutes {
  static appRoutes() => [
    GetPage(
      name: RouteName.splashScreen,
      page: () => const SplashScreen(),
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(microseconds: 250),
    ),
    GetPage(
      name: RouteName.languageScreen,
      page: () => const LanguageScreen(),
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(microseconds: 250),
    ),
    GetPage(
      name: RouteName.loginScreen,
      page: () => const LoginScreen(),
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(microseconds: 250),
    ),
    GetPage(
      name: RouteName.registerScreen,
      page: () => const RegisterScreen(),
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(microseconds: 250),
    ),
    GetPage(
      name: RouteName.forgotPasswordScreen,
      page: () => const ForgotPasswordScreen(),
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(microseconds: 250),
    ),
    GetPage(
      name: RouteName.navBarScreen,
      page: () => BottomNavigationBarScreen(),
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(microseconds: 250),
      middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: RouteName.homeScreen,
      page: () => const HomeScreen(),
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(microseconds: 250),
      middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: RouteName.videoScreen,
      page: () => VideoScreen(videoId: Get.parameters['videoId'] ?? ''),
      transition: Transition.zoom,
      transitionDuration: const Duration(milliseconds: 250),
      middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: RouteName.changePasswordScreen,
      page: () => const ChangePasswordScreen(),
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(microseconds: 250),
      middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: RouteName.updateAccountScreen,
      page: () => const UpdateAccountScreen(),
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(microseconds: 250),
      middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: RouteName.updateAvatarScreen,
      page: () => const UpdateAvatarScreen(),
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(microseconds: 250),
      middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: RouteName.updateCoverImageScreen,
      page: () => const UpdateCoverImageScreen(),
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(microseconds: 250),
      middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: RouteName.watchHistory,
      page: () => const WatchHistoryScreen(),
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(microseconds: 250),
      middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: RouteName.profileScreen,
      page: () => const ProfileScreen(),
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(microseconds: 250),
      middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: RouteName.likedVideoScreen,
      page: () => const LikedVideoScreen(),
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(microseconds: 250),
      middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: RouteName.updateVideoScreen,
      page: () => UpdateVideoScreen(videoId: Get.parameters['videoId'] ?? ''),
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(microseconds: 250),
      middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: RouteName.userScreen,
      page: () => UserScreen(userId: Get.parameters['userId'] ?? ''),
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(microseconds: 250),
      middlewares: [AuthMiddleware()]
    ),
  ];
}
