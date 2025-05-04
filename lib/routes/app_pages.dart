import 'package:get/get.dart';
import '../bindings/home_binding.dart';
import '../bindings/splash_screen_binding.dart';
import '../views/home_view.dart';
import '../views/splash_screen_view.dart.dart';

class AppPages {
  static const initial = '/splash';

  static final routes = [
    GetPage(
      name: '/splash',
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: '/home',
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
  ];
}
