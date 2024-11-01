import 'package:get/get.dart';
import 'package:toiletmap/app/modules/home/controllers/profileedit_controller.dart';

class ProfileEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileEditController>(() => ProfileEditController());
  }
}
