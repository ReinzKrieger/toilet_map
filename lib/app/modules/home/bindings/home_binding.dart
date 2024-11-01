import 'package:get/get.dart';

import 'package:toiletmap/app/modules/home/controllers/auth_controller.dart';
import 'package:toiletmap/app/modules/home/controllers/feed_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FeedController>(
      () => FeedController(),
    );
    Get.lazyPut<AuthController>(
      () => AuthController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
