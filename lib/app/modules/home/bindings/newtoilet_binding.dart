import 'package:get/get.dart';
import 'package:toiletmap/app/modules/home/controllers/newtoilet_controller.dart';

class NewToiletBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewToiletController>(() => NewToiletController());
  }
}
