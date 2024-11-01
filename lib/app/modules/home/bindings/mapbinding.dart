import 'package:get/get.dart';
import 'package:toiletmap/app/modules/home/controllers/map_controller.dart';

class MapBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MapController>(() => MapController());
  }
}
