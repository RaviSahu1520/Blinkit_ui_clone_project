import 'package:get/get.dart';
import 'package:katyayani_project/controllers/splash_screen_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
  }
}
