import 'package:get/get.dart';
import 'package:stream_vids/res/routes/route_name.dart';
import 'package:stream_vids/view/splash_screen.dart';

class AppRoutes {
  static appRoutes() => [
    GetPage(name: RouteName.splashScreen, page: () => const SplashScreen(),
    transition: Transition.leftToRightWithFade,
    transitionDuration: const Duration(microseconds: 250)
    )
  ];
}
